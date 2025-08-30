import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/screen_utils.dart';

class ManagerActionGrid extends StatelessWidget {
  const ManagerActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      ManagerAction(
        icon: Icons.group,
        title: 'Squad',
        subtitle: 'Manage players',
        color: Colors.blue,
        route: '/squad',
      ),
      ManagerAction(
        icon: Icons.sports_soccer,
        title: 'Tactics',
        subtitle: 'Set formation',
        color: Colors.green,
        route: '/tactics',
      ),
      ManagerAction(
        icon: Icons.swap_horiz,
        title: 'Transfers',
        subtitle: 'Buy & sell',
        color: Colors.orange,
        route: '/transfers',
      ),
      ManagerAction(
        icon: Icons.table_chart,
        title: 'League',
        subtitle: 'Table & fixtures',
        color: Colors.purple,
        route: '/league',
      ),
      ManagerAction(
        icon: Icons.attach_money,
        title: 'Finances',
        subtitle: 'Budget & wages',
        color: Colors.indigo,
        route: '/finances',
      ),
      ManagerAction(
        icon: Icons.fitness_center,
        title: 'Training',
        subtitle: 'Player development',
        color: Colors.red,
        route: '/training',
      ),
      ManagerAction(
        icon: Icons.add_circle,
        title: 'Create League',
        subtitle: 'Generate new league',
        color: Colors.teal,
        route: '/league-creator',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use responsive utilities for optimal layout
        final crossAxisCount = ScreenUtils.getResponsiveGridCount(context);
        final aspectRatio = ScreenUtils.getCardAspectRatio(context);
        final spacing = ScreenUtils.getResponsiveSpacing(context, baseSpacing: 12);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _buildActionCard(context, action);
          },
        );
      },
    );
  }

  Widget _buildActionCard(BuildContext context, ManagerAction action) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.push(action.route);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                action.color.withOpacity(0.1),
                action.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtils.getResponsiveSpacing(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8), // Further reduced padding
                  decoration: BoxDecoration(
                    color: action.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    action.icon,
                    size: 24, // Further reduced icon size
                    color: action.color,
                  ),
                ),
                const SizedBox(height: 6), // Further reduced spacing
                Text(
                  action.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 1), // Further reduced spacing
                Text(
                  action.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManagerAction {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;

  const ManagerAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });
}
