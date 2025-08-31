import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tactics_fc_engine/soccer_engine.dart' as engine;
import 'package:tactics_fc_generator/soccer_data_generator.dart';

// Events
abstract class LeagueGenerationEvent extends Equatable {
  const LeagueGenerationEvent();

  @override
  List<Object?> get props => [];
}

class LoadCountriesEvent extends LeagueGenerationEvent {}

class SelectCountryEvent extends LeagueGenerationEvent {
  final Country country;

  const SelectCountryEvent(this.country);

  @override
  List<Object?> get props => [country];
}

class UpdateLeagueConfigEvent extends LeagueGenerationEvent {
  final GenerationConfig config;

  const UpdateLeagueConfigEvent(this.config);

  @override
  List<Object?> get props => [config];
}

class GenerateLeagueEvent extends LeagueGenerationEvent {
  final String leagueName;

  const GenerateLeagueEvent(this.leagueName);

  @override
  List<Object?> get props => [leagueName];
}

class ResetLeagueGenerationEvent extends LeagueGenerationEvent {}

// States
abstract class LeagueGenerationState extends Equatable {
  const LeagueGenerationState();

  @override
  List<Object?> get props => [];
}

class LeagueGenerationInitial extends LeagueGenerationState {}

class LeagueGenerationLoading extends LeagueGenerationState {}

class CountriesLoaded extends LeagueGenerationState {
  final List<Country> countries;
  final List<Country> strongSoccerCountries;

  const CountriesLoaded({
    required this.countries,
    required this.strongSoccerCountries,
  });

  @override
  List<Object?> get props => [countries, strongSoccerCountries];
}

class CountrySelected extends LeagueGenerationState {
  final Country selectedCountry;
  final GenerationConfig config;
  final List<Country> allCountries;

  const CountrySelected({
    required this.selectedCountry,
    required this.config,
    required this.allCountries,
  });

  @override
  List<Object?> get props => [selectedCountry, config, allCountries];
}

class LeagueConfiguring extends LeagueGenerationState {
  final Country selectedCountry;
  final GenerationConfig config;
  final List<Country> allCountries;

  const LeagueConfiguring({
    required this.selectedCountry,
    required this.config,
    required this.allCountries,
  });

  @override
  List<Object?> get props => [selectedCountry, config, allCountries];
}

class LeagueGenerating extends LeagueGenerationState {
  final Country selectedCountry;
  final GenerationConfig config;
  final String leagueName;
  final double progress;
  final String currentStep;

  const LeagueGenerating({
    required this.selectedCountry,
    required this.config,
    required this.leagueName,
    this.progress = 0.0,
    this.currentStep = '',
  });

  @override
  List<Object?> get props => [selectedCountry, config, leagueName, progress, currentStep];
}

class LeagueGenerated extends LeagueGenerationState {
  final engine.League league;
  final Country selectedCountry;
  final GenerationConfig config;
  final String leagueName;
  final List<engine.Team> teamsWithPlayers;

  const LeagueGenerated({
    required this.league,
    required this.selectedCountry,
    required this.config,
    required this.leagueName,
    required this.teamsWithPlayers,
  });

  @override
  List<Object?> get props => [league, selectedCountry, config, leagueName, teamsWithPlayers];
}

class LeagueGenerationError extends LeagueGenerationState {
  final String message;
  final Country? selectedCountry;
  final List<Country>? allCountries;

  const LeagueGenerationError({
    required this.message,
    this.selectedCountry,
    this.allCountries,
  });

  @override
  List<Object?> get props => [message, selectedCountry, allCountries];
}

// BLoC
class LeagueGenerationBloc extends Bloc<LeagueGenerationEvent, LeagueGenerationState> {
  final CountryGenerator _countryGenerator = CountryGenerator();
  final LeagueGenerator _leagueGenerator = LeagueGenerator(seed: 42);
  final TeamGenerator _teamGenerator = TeamGenerator(seed: 42);
  final PlayerGenerator _playerGenerator = PlayerGenerator(seed: 42);

  LeagueGenerationBloc() : super(LeagueGenerationInitial()) {
    on<LoadCountriesEvent>(_onLoadCountries);
    on<SelectCountryEvent>(_onSelectCountry);
    on<UpdateLeagueConfigEvent>(_onUpdateLeagueConfig);
    on<GenerateLeagueEvent>(_onGenerateLeague);
    on<ResetLeagueGenerationEvent>(_onResetLeagueGeneration);
  }

  void _onLoadCountries(LoadCountriesEvent event, Emitter<LeagueGenerationState> emit) async {
    emit(LeagueGenerationLoading());
    
    try {
      final allCountries = CountryGenerator.getAllCountries();
      final strongCountries = CountryGenerator.getStrongSoccerCountries();
      
      emit(CountriesLoaded(
        countries: allCountries,
        strongSoccerCountries: strongCountries,
      ));
    } catch (e) {
      emit(LeagueGenerationError(message: 'Failed to load countries: ${e.toString()}'));
    }
  }

  void _onSelectCountry(SelectCountryEvent event, Emitter<LeagueGenerationState> emit) async {
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      
      try {
        final config = GenerationConfig.defaultForCountry(event.country);
        
        emit(CountrySelected(
          selectedCountry: event.country,
          config: config,
          allCountries: currentState.countries,
        ));
      } catch (e) {
        emit(LeagueGenerationError(
          message: 'Failed to create configuration for ${event.country.name}: ${e.toString()}',
          allCountries: currentState.countries,
        ));
      }
    }
  }

  void _onUpdateLeagueConfig(UpdateLeagueConfigEvent event, Emitter<LeagueGenerationState> emit) {
    if (state is CountrySelected) {
      final currentState = state as CountrySelected;
      
      emit(LeagueConfiguring(
        selectedCountry: currentState.selectedCountry,
        config: event.config,
        allCountries: currentState.allCountries,
      ));
    } else if (state is LeagueConfiguring) {
      final currentState = state as LeagueConfiguring;
      
      emit(LeagueConfiguring(
        selectedCountry: currentState.selectedCountry,
        config: event.config,
        allCountries: currentState.allCountries,
      ));
    }
  }

  void _onGenerateLeague(GenerateLeagueEvent event, Emitter<LeagueGenerationState> emit) async {
    if (state is CountrySelected || state is LeagueConfiguring) {
      final currentState = state as dynamic;
      final Country selectedCountry = currentState.selectedCountry;
      final GenerationConfig config = currentState.config;
      
      emit(LeagueGenerating(
        selectedCountry: selectedCountry,
        config: config,
        leagueName: event.leagueName,
        progress: 0.0,
        currentStep: 'Initializing...',
      ));

      try {
        // Step 1: Generate complete league with variable squad sizes
        emit(LeagueGenerating(
          selectedCountry: selectedCountry,
          config: config,
          leagueName: event.leagueName,
          progress: 0.1,
          currentStep: 'Generating teams and determining squad sizes...',
        ));

        // Use the new generateCompleteLeague method that supports variable squad sizes
        final generatedLeague = await _leagueGenerator.generateCompleteLeague(
          country: selectedCountry,
          config: config,
        );
        
        final leagueData = generatedLeague.teams;

        // Step 2: Create league structure
        emit(LeagueGenerating(
          selectedCountry: selectedCountry,
          config: config,
          leagueName: event.leagueName,
          progress: 0.8,
          currentStep: 'Creating league structure...',
        ));

        final league = engine.League(
          id: 'generated_${DateTime.now().millisecondsSinceEpoch}',
          name: event.leagueName.isEmpty ? config.leagueConfig.nameFormat : event.leagueName,
          country: selectedCountry.code,
          teams: leagueData,
          tier: engine.LeagueTier.tier1,
          format: engine.LeagueFormat.roundRobin,
          foundedYear: DateTime.now().year,
          maxTeams: config.leagueConfig.teamsPerDivision,
          minTeams: 8,
        );

        // Step 3: Finalize
        emit(LeagueGenerating(
          selectedCountry: selectedCountry,
          config: config,
          leagueName: event.leagueName,
          progress: 1.0,
          currentStep: 'Finalizing...',
        ));

        emit(LeagueGenerated(
          league: league,
          selectedCountry: selectedCountry,
          config: config,
          leagueName: event.leagueName,
          teamsWithPlayers: leagueData,
        ));

      } catch (e) {
        emit(LeagueGenerationError(
          message: 'Failed to generate league: ${e.toString()}',
          selectedCountry: selectedCountry,
        ));
      }
    }
  }

  void _onResetLeagueGeneration(ResetLeagueGenerationEvent event, Emitter<LeagueGenerationState> emit) {
    emit(LeagueGenerationInitial());
  }
}
