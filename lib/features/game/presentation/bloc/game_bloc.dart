import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tactics_fc_engine/soccer_engine.dart' as engine;

// Events
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class InitializeGameEvent extends GameEvent {}

class AdvanceDayEvent extends GameEvent {}

class UpdateGameStateEvent extends GameEvent {
  final engine.GameState newGameState;

  const UpdateGameStateEvent(this.newGameState);

  @override
  List<Object?> get props => [newGameState];
}

class LoadGameEvent extends GameEvent {
  final Map<String, dynamic> saveData;

  const LoadGameEvent(this.saveData);

  @override
  List<Object?> get props => [saveData];
}

// States
abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final engine.GameState gameState;

  const GameLoaded(this.gameState);

  @override
  List<Object?> get props => [gameState];
}

class GameError extends GameState {
  final String message;

  const GameError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<InitializeGameEvent>(_onInitializeGame);
    on<AdvanceDayEvent>(_onAdvanceDay);
    on<UpdateGameStateEvent>(_onUpdateGameState);
    on<LoadGameEvent>(_onLoadGame);
  }

  void _onInitializeGame(InitializeGameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());
    
    try {
      // Create a sample league and initialize the game
      final teams = <engine.Team>[
        engine.Team(
          id: 'team-1',
          name: 'Arsenal',
          city: 'London',
          foundedYear: 1886,
          players: _createSamplePlayers('arsenal'),
        ),
        engine.Team(
          id: 'team-2',
          name: 'Manchester United',
          city: 'Manchester',
          foundedYear: 1878,
          players: _createSamplePlayers('manchester'),
        ),
        engine.Team(
          id: 'team-3',
          name: 'Liverpool',
          city: 'Liverpool',
          foundedYear: 1892,
          players: _createSamplePlayers('liverpool'),
        ),
        engine.Team(
          id: 'team-4',
          name: 'Chelsea',
          city: 'London',
          foundedYear: 1905,
          players: _createSamplePlayers('chelsea'),
        ),
      ];

      final league = engine.League(
        id: 'premier-league',
        name: 'Premier League',
        country: 'England',
        teams: teams,
        minTeams: 4,
        maxTeams: 20,
      );

      final gameState = engine.GameState.initialize(
        league: league,
        playerTeamId: 'team-1', // Player controls Arsenal
        startDate: DateTime(2025, 8, 1),
      );

      emit(GameLoaded(gameState));
    } catch (e) {
      emit(GameError('Failed to initialize game: ${e.toString()}'));
    }
  }

  void _onAdvanceDay(AdvanceDayEvent event, Emitter<GameState> emit) async {
    if (state is GameLoaded) {
      emit(GameLoading());
      
      try {
        final currentState = (state as GameLoaded).gameState;
        final newGameState = currentState.advanceDay();
        
        // TODO: Process AI decisions for other teams
        // TODO: Check for matches scheduled for today
        // TODO: Update league standings if matches were played
        
        emit(GameLoaded(newGameState));
      } catch (e) {
        emit(GameError('Failed to advance day: ${e.toString()}'));
      }
    }
  }

  void _onUpdateGameState(UpdateGameStateEvent event, Emitter<GameState> emit) {
    emit(GameLoaded(event.newGameState));
  }

  void _onLoadGame(LoadGameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());
    
    try {
      final gameState = engine.GameState.fromSaveData(event.saveData);
      emit(GameLoaded(gameState));
    } catch (e) {
      emit(GameError('Failed to load game: ${e.toString()}'));
    }
  }

  List<engine.Player> _createSamplePlayers(String teamPrefix) {
    return [
      // Goalkeepers
      engine.Player(
        id: '${teamPrefix}_gk1',
        name: 'John Keeper',
        age: 28,
        position: engine.PlayerPosition.goalkeeper,
        technical: 85,
        physical: 75,
        mental: 82,
      ),
      engine.Player(
        id: '${teamPrefix}_gk2',
        name: 'David Saves',
        age: 32,
        position: engine.PlayerPosition.goalkeeper,
        technical: 78,
        physical: 70,
        mental: 85,
      ),
      // Defenders
      engine.Player(
        id: '${teamPrefix}_def1',
        name: 'Mike Defender',
        age: 26,
        position: engine.PlayerPosition.defender,
        technical: 72,
        physical: 85,
        mental: 78,
      ),
      engine.Player(
        id: '${teamPrefix}_def2',
        name: 'Tom Shield',
        age: 29,
        position: engine.PlayerPosition.defender,
        technical: 75,
        physical: 82,
        mental: 80,
      ),
      engine.Player(
        id: '${teamPrefix}_def3',
        name: 'Alex Block',
        age: 24,
        position: engine.PlayerPosition.defender,
        technical: 70,
        physical: 88,
        mental: 75,
      ),
      engine.Player(
        id: '${teamPrefix}_def4',
        name: 'Sam Guard',
        age: 27,
        position: engine.PlayerPosition.defender,
        technical: 73,
        physical: 84,
        mental: 79,
      ),
      // Midfielders
      engine.Player(
        id: '${teamPrefix}_mid1',
        name: 'Paul Passer',
        age: 25,
        position: engine.PlayerPosition.midfielder,
        technical: 88,
        physical: 75,
        mental: 82,
      ),
      engine.Player(
        id: '${teamPrefix}_mid2',
        name: 'Chris Creative',
        age: 23,
        position: engine.PlayerPosition.midfielder,
        technical: 85,
        physical: 72,
        mental: 88,
      ),
      engine.Player(
        id: '${teamPrefix}_mid3',
        name: 'Mark Engine',
        age: 28,
        position: engine.PlayerPosition.midfielder,
        technical: 80,
        physical: 85,
        mental: 78,
      ),
      engine.Player(
        id: '${teamPrefix}_mid4',
        name: 'James Control',
        age: 26,
        position: engine.PlayerPosition.midfielder,
        technical: 82,
        physical: 78,
        mental: 85,
      ),
      // Forwards
      engine.Player(
        id: '${teamPrefix}_fwd1',
        name: 'Robert Scorer',
        age: 24,
        position: engine.PlayerPosition.forward,
        technical: 90,
        physical: 80,
        mental: 82,
      ),
      engine.Player(
        id: '${teamPrefix}_fwd2',
        name: 'Danny Goal',
        age: 27,
        position: engine.PlayerPosition.forward,
        technical: 88,
        physical: 85,
        mental: 80,
      ),
      engine.Player(
        id: '${teamPrefix}_fwd3',
        name: 'Steve Strike',
        age: 22,
        position: engine.PlayerPosition.forward,
        technical: 85,
        physical: 78,
        mental: 75,
      ),
      engine.Player(
        id: '${teamPrefix}_fwd4',
        name: 'Kevin Finish',
        age: 29,
        position: engine.PlayerPosition.forward,
        technical: 87,
        physical: 82,
        mental: 88,
      ),
    ];
  }
}
