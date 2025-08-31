import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tactics_fc_generator/soccer_data_generator.dart';
import '../bloc/league_generation_bloc.dart';

class LeagueCreatorPage extends StatefulWidget {
  const LeagueCreatorPage({super.key});

  @override
  State<LeagueCreatorPage> createState() => _LeagueCreatorPageState();
}

class _LeagueCreatorPageState extends State<LeagueCreatorPage> {
  final TextEditingController _leagueNameController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Load countries when the page opens
    context.read<LeagueGenerationBloc>().add(LoadCountriesEvent());
  }

  @override
  void dispose() {
    _leagueNameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New League'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_currentPage > 0)
            TextButton(
              onPressed: _previousPage,
              child: const Text('Back'),
            ),
        ],
      ),
      body: BlocListener<LeagueGenerationBloc, LeagueGenerationState>(
        listener: (context, state) {
          if (state is LeagueGenerated) {
            // Show success dialog and optionally navigate to league view
            _showSuccessDialog(context, state);
          } else if (state is LeagueGenerationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCountrySelectionPage(),
                  _buildLeagueConfigurationPage(),
                  _buildGenerationPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildProgressStep(0, 'Country', _currentPage >= 0),
          Expanded(child: Container(height: 2, color: _currentPage >= 1 ? Colors.blue : Colors.grey[300])),
          _buildProgressStep(1, 'Configure', _currentPage >= 1),
          Expanded(child: Container(height: 2, color: _currentPage >= 2 ? Colors.blue : Colors.grey[300])),
          _buildProgressStep(2, 'Generate', _currentPage >= 2),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              '${step + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.blue : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCountrySelectionPage() {
    return BlocBuilder<LeagueGenerationBloc, LeagueGenerationState>(
      builder: (context, state) {
        if (state is LeagueGenerationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CountriesLoaded) {
          return _buildCountryGrid(state.countries, state.strongSoccerCountries);
        }

        if (state is LeagueGenerationError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<LeagueGenerationBloc>().add(LoadCountriesEvent()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCountryGrid(List<Country> allCountries, List<Country> strongCountries) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select a Country',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose the country for your new league',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Strong soccer countries section
          const Text(
            'Popular Soccer Nations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: strongCountries.length,
            itemBuilder: (context, index) {
              final country = strongCountries[index];
              return _buildCountryCard(country, isPopular: true);
            },
          ),
          
          const SizedBox(height: 32),
          
          // All countries section
          const Text(
            'All Countries',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: allCountries.length,
            itemBuilder: (context, index) {
              final country = allCountries[index];
              return _buildCountryCard(country);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCountryCard(Country country, {bool isPopular = false}) {
    return Card(
      elevation: isPopular ? 4 : 2,
      child: InkWell(
        onTap: () {
          context.read<LeagueGenerationBloc>().add(SelectCountryEvent(country));
          _nextPage();
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: isPopular ? Border.all(color: Colors.blue, width: 2) : null,
          ),
          child: Row(
            children: [
              // Country flag placeholder
              Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    country.code,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      country.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (country.strongSoccerCulture)
                      Row(
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          const Text(
                            'Popular',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueConfigurationPage() {
    return BlocBuilder<LeagueGenerationBloc, LeagueGenerationState>(
      builder: (context, state) {
        if (state is CountrySelected || state is LeagueConfiguring) {
          final country = state is CountrySelected 
              ? (state as CountrySelected).selectedCountry 
              : (state as LeagueConfiguring).selectedCountry;
          final config = state is CountrySelected 
              ? (state as CountrySelected).config 
              : (state as LeagueConfiguring).config;

          return _buildConfigurationForm(country, config);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildConfigurationForm(Country country, GenerationConfig config) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected country display
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        country.code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          country.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Creating league for ${country.name}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // League name input
          const Text(
            'League Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _leagueNameController,
            decoration: InputDecoration(
              hintText: config.leagueConfig.nameFormat,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.sports_soccer),
            ),
          ),

          const SizedBox(height: 24),

          // Configuration options
          _buildConfigSection('League Settings', [
            _buildConfigRow(
              'Teams per Division',
              '${config.leagueConfig.teamsPerDivision}',
              Icons.groups,
            ),
            _buildConfigRow(
              'Number of Divisions',
              '${config.leagueConfig.divisions}',
              Icons.layers,
            ),
            _buildConfigRow(
              'Generate Cups',
              config.leagueConfig.generateCups ? 'Yes' : 'No',
              Icons.emoji_events,
            ),
          ]),

          const SizedBox(height: 16),

          _buildConfigSection('Team Settings', [
            _buildConfigRow(
              'Realistic Distribution',
              config.teamConfig.useRealisticDistribution ? 'Yes' : 'No',
              Icons.analytics,
            ),
            _buildConfigRow(
              'Traditional Names',
              config.teamConfig.useTraditionalNames ? 'Yes' : 'No',
              Icons.history,
            ),
          ]),

          const SizedBox(height: 16),

          _buildConfigSection('Player Settings', [
            _buildConfigRow(
              'Squad Size',
              config.playerConfig.useVariableSquadSizes 
                  ? '${config.playerConfig.minSquadSize}-${config.playerConfig.maxSquadSize} players (varies by team reputation)'
                  : '${config.playerConfig.averageSquadSize} players (fixed)',
              Icons.person,
            ),
            _buildConfigRow(
              'Domestic Players',
              '${config.playerConfig.domesticPlayerPercentage}%',
              Icons.flag,
            ),
            _buildConfigRow(
              'Realistic Positions',
              config.playerConfig.useRealisticPositions ? 'Yes' : 'No',
              Icons.sports,
            ),
          ]),

          const SizedBox(height: 32),

          // Generate button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final leagueName = _leagueNameController.text.trim();
                context.read<LeagueGenerationBloc>().add(GenerateLeagueEvent(leagueName));
                _nextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome),
                  SizedBox(width: 8),
                  Text('Generate League', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildConfigRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerationPage() {
    return BlocBuilder<LeagueGenerationBloc, LeagueGenerationState>(
      builder: (context, state) {
        if (state is LeagueGenerating) {
          return _buildGenerationProgress(state);
        }

        if (state is LeagueGenerated) {
          return _buildGenerationComplete(state);
        }

        if (state is LeagueGenerationError) {
          return _buildGenerationError(state);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildGenerationProgress(LeagueGenerating state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Generating Your League',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              state.currentStep,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              '${(state.progress * 100).toInt()}%',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerationComplete(LeagueGenerated state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'League Generated!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              state.league.name,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${state.league.teams.length} teams with ${state.teamsWithPlayers.fold(0, (sum, team) => sum + team.players.length)} players',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Save league and go to saved leagues
                      context.pop();
                    },
                    child: const Text('Save League'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Use this league in game
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Use in Game'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerationError(LeagueGenerationError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            const Text(
              'Generation Failed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<LeagueGenerationBloc>().add(ResetLeagueGenerationEvent());
                _currentPage = 0;
                _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                setState(() {});
              },
              child: const Text('Start Over'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, LeagueGenerated state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('League Created Successfully!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('League: ${state.league.name}'),
            Text('Country: ${state.selectedCountry.name}'),
            Text('Teams: ${state.league.teams.length}'),
            Text('Total Players: ${state.teamsWithPlayers.fold(0, (sum, team) => sum + team.players.length)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
