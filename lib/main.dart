import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'features/game/presentation/bloc/game_bloc.dart';
import 'features/league/presentation/bloc/league_generation_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/squad/presentation/pages/squad_page.dart';
import 'features/tactics/presentation/pages/tactics_page.dart';
import 'features/transfers/presentation/pages/transfers_page.dart';
import 'features/league/presentation/pages/league_page.dart';
import 'features/league/presentation/pages/league_creator_page.dart';
import 'features/finances/presentation/pages/finances_page.dart';
import 'features/main_menu/presentation/pages/main_menu_page.dart';

void main() {
  runApp(TacticsFCApp());
}

class TacticsFCApp extends StatelessWidget {
  TacticsFCApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'main-menu',
        builder: (context, state) => const MainMenuPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/squad',
        name: 'squad',
        builder: (context, state) => const SquadPage(),
      ),
      GoRoute(
        path: '/tactics',
        name: 'tactics',
        builder: (context, state) => const TacticsPage(),
      ),
      GoRoute(
        path: '/transfers',
        name: 'transfers',
        builder: (context, state) => const TransfersPage(),
      ),
      GoRoute(
        path: '/league',
        name: 'league',
        builder: (context, state) => const LeaguePage(),
      ),
      GoRoute(
        path: '/finances',
        name: 'finances',
        builder: (context, state) => const FinancesPage(),
      ),
      GoRoute(
        path: '/league-creator',
        name: 'league-creator',
        builder: (context, state) => const LeagueCreatorPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (context) => GameBloc()..add(InitializeGameEvent()),
        ),
        BlocProvider<LeagueGenerationBloc>(
          create: (context) => LeagueGenerationBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Tactics FC',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
