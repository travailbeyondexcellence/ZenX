import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Progress dashboard screen (Hevy style)
class ProgressDashboardScreen extends BaseScreen {
  const ProgressDashboardScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      title: const Text(
        'Analytics',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Refresh analytics
        await Future.delayed(const Duration(seconds: 1));
      },
      child: CustomScrollView(
        slivers: [
          // Overview stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.paddingScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Week',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  const Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Workouts',
                          value: '4',
                          icon: Icons.fitness_center,
                          color: HevyColors.primary,
                        ),
                      ),
                      SizedBox(width: DesignTokens.spacingM),
                      Expanded(
                        child: _StatCard(
                          label: 'Volume',
                          value: '12.5k',
                          icon: Icons.trending_up,
                          color: HevyColors.accent,
                        ),
                      ),
                      SizedBox(width: DesignTokens.spacingM),
                      Expanded(
                        child: _StatCard(
                          label: 'PRs',
                          value: '2',
                          icon: Icons.emoji_events,
                          color: HevyColors.accentOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Quick links
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.paddingScreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Insights',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/analytics/statistics');
                        },
                        child: const Text(
                          'Statistics',
                          style: TextStyle(color: HevyColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  _InsightCard(
                    title: 'Statistics',
                    subtitle: 'View graphs and analytics',
                    icon: Icons.bar_chart,
                    color: HevyColors.primary,
                    onTap: () => context.push('/analytics/statistics'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Personal Records',
                    subtitle: 'View your best lifts',
                    icon: Icons.emoji_events,
                    color: HevyColors.accentOrange,
                    onTap: () => context.push('/analytics/personal-records'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Volume Analysis',
                    subtitle: 'Track training volume over time',
                    icon: Icons.bar_chart,
                    color: HevyColors.primary,
                    onTap: () => context.push('/analytics/volume-analysis'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Strength Progression',
                    subtitle: 'See your strength gains',
                    icon: Icons.trending_up,
                    color: HevyColors.accent,
                    onTap: () => context.push('/analytics/strength-progression'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Set Count Per Muscle',
                    subtitle: 'See your muscle group stats',
                    icon: Icons.trending_up,
                    color: HevyColors.primary,
                    onTap: () => context.push('/analytics/set-count-per-muscle'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Muscle Distribution',
                    subtitle: 'Compare muscle distributions',
                    icon: Icons.multiline_chart,
                    color: HevyColors.accent,
                    onTap: () => context.push('/analytics/muscle-distribution'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Body Distribution',
                    subtitle: 'Weekly heat map of muscles',
                    icon: Icons.person,
                    color: HevyColors.primary,
                    onTap: () => context.push('/analytics/body-distribution'),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _InsightCard(
                    title: 'Monthly Report',
                    subtitle: 'View monthly workout summary',
                    icon: Icons.description,
                    color: HevyColors.accentOrange,
                    onTap: () => context.push('/analytics/monthly-report'),
                  ),
                ],
              ),
            ),
          ),

          // Recent PRs
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.paddingScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Personal Records',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  _PRCard(
                    exercise: 'Bench Press',
                    value: '100 kg',
                    type: '1RM',
                    date: DateTime.now().subtract(const Duration(days: 2)),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _PRCard(
                    exercise: 'Squat',
                    value: '150 kg',
                    type: '1RM',
                    date: DateTime.now().subtract(const Duration(days: 5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat card widget
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: DesignTokens.iconMedium, // 24dp
            ),
            const SizedBox(height: DesignTokens.spacingS),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: DesignTokens.spacingXXS),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Insight card widget
class _InsightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _InsightCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacingM),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: DesignTokens.iconMedium, // 24dp
                ),
              ),
              const SizedBox(width: DesignTokens.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: DesignTokens.spacingXXS),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: HevyColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Personal record card
class _PRCard extends StatelessWidget {
  final String exercise;
  final String value;
  final String type;
  final DateTime date;

  const _PRCard({
    required this.exercise,
    required this.value,
    required this.type,
    required this.date,
  });

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingM),
              decoration: BoxDecoration(
                color: HevyColors.accentOrange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: HevyColors.accentOrange,
                size: DesignTokens.iconMedium, // 24dp
              ),
            ),
            const SizedBox(width: DesignTokens.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: DesignTokens.spacingXXS),
                  Row(
                    children: [
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HevyColors.accentOrange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: DesignTokens.spacingXS),
                      Chip(
                        label: Text(type),
                        backgroundColor: HevyColors.surfaceElevated,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              _getTimeAgo(date),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
