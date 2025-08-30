import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_engine/soccer_engine.dart' as engine;

import '../../../../core/utils/screen_utils.dart';
import '../../../game/presentation/bloc/game_bloc.dart';
import '../widgets/day_info_card.dart';
import '../widgets/manager_action_grid.dart';
import '../widgets/quick_stats_card.dart';
import '../widgets/next_match_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GameError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading game',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().add(InitializeGameEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is GameLoaded) {
            return _buildDashboard(context, state.gameState);
          }

          return const Center(
            child: Text('Welcome to Soccer Manager'),
          );
        },
      ),
      floatingActionButton: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            return FloatingActionButton.extended(
              onPressed: () {
                context.read<GameBloc>().add(AdvanceDayEvent());
              },
              icon: const Icon(Icons.fast_forward),
              label: const Text('End Day'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, engine.GameState gameState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GameBloc>().add(InitializeGameEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(ScreenUtils.getResponsiveSpacing(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day and date information
            DayInfoCard(gameState: gameState),
            SizedBox(height: ScreenUtils.getResponsiveSpacing(context)),

            // Quick stats overview
            QuickStatsCard(gameState: gameState),
            SizedBox(height: ScreenUtils.getResponsiveSpacing(context)),

            // Next match information
            NextMatchCard(gameState: gameState),
            SizedBox(height: ScreenUtils.getResponsiveSpacing(context, baseSpacing: 24)),

            // Manager actions grid
            Text(
              'Manager Actions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ScreenUtils.getResponsiveSpacing(context, baseSpacing: 12)),
            const ManagerActionGrid(),
          ],
        ),
      ),
    );
  }
}
