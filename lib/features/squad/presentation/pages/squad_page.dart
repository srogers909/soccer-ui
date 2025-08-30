import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_engine/soccer_engine.dart' as engine;

import '../../../game/presentation/bloc/game_bloc.dart';

class SquadPage extends StatelessWidget {
  const SquadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Squad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            return _buildSquadView(context, state.gameState);
          }
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildSquadView(BuildContext context, engine.GameState gameState) {
    final players = gameState.playerTeam.players;
    
    // Group players by position
    final goalkeepers = players.where((p) => p.position == engine.PlayerPosition.goalkeeper).toList();
    final defenders = players.where((p) => p.position == engine.PlayerPosition.defender).toList();
    final midfielders = players.where((p) => p.position == engine.PlayerPosition.midfielder).toList();
    final forwards = players.where((p) => p.position == engine.PlayerPosition.forward).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${gameState.playerTeam.name} Squad',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${players.length} players',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          
          if (goalkeepers.isNotEmpty) ...[
            _buildPositionSection(context, 'Goalkeepers', goalkeepers, Icons.sports_handball),
            const SizedBox(height: 16),
          ],
          
          if (defenders.isNotEmpty) ...[
            _buildPositionSection(context, 'Defenders', defenders, Icons.shield),
            const SizedBox(height: 16),
          ],
          
          if (midfielders.isNotEmpty) ...[
            _buildPositionSection(context, 'Midfielders', midfielders, Icons.control_camera),
            const SizedBox(height: 16),
          ],
          
          if (forwards.isNotEmpty) ...[
            _buildPositionSection(context, 'Forwards', forwards, Icons.sports_soccer),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildPositionSection(BuildContext context, String title, List<engine.Player> players, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Chip(
              label: Text('${players.length}'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...players.map((player) => _buildPlayerCard(context, player)),
      ],
    );
  }

  Widget _buildPlayerCard(BuildContext context, engine.Player player) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            player.name.split(' ').map((name) => name.isNotEmpty ? name[0] : '').join(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          player.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Age: ${player.age}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'OVR',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${player.overallRating}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: _getRatingColor(context, player.overallRating),
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to player details
        },
      ),
    );
  }

  Color _getRatingColor(BuildContext context, int rating) {
    if (rating >= 85) return Colors.green;
    if (rating >= 75) return Colors.orange;
    if (rating >= 65) return Colors.blue;
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }
}
