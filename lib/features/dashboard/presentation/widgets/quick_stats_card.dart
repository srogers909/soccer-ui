import 'package:flutter/material.dart';
import 'package:soccer_engine/soccer_engine.dart' as engine;

class QuickStatsCard extends StatelessWidget {
  final engine.GameState gameState;

  const QuickStatsCard({
    super.key,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    final playerTeam = gameState.playerTeam;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.sports_soccer,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  playerTeam.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Icons.group,
                    label: 'Squad Size',
                    value: '${playerTeam.players.length}',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Icons.location_city,
                    label: 'City',
                    value: playerTeam.city,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Icons.calendar_month,
                    label: 'Founded',
                    value: '${playerTeam.foundedYear}',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Icons.emoji_events,
                    label: 'Position',
                    value: _getLeaguePosition(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _getLeaguePosition() {
    // Simple calculation - in a real app this would come from league standings
    final teams = gameState.league.teams;
    final playerTeamIndex = teams.indexWhere((team) => team.id == gameState.playerTeamId);
    return '${playerTeamIndex + 1}/${teams.length}';
  }
}
