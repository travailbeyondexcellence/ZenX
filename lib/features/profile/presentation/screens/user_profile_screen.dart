import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// User profile screen (pixel-perfect Hevy style)
class UserProfileScreen extends BaseScreen {
  const UserProfileScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      toolbarHeight: 56,
      leadingWidth: 140,
      leading: Padding(
        padding: const EdgeInsets.only(left: DesignTokens.paddingScreen),
        child: TextButton(
          onPressed: () => context.push('/profile/edit'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingS),
            foregroundColor: HevyColors.primary,
            textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          child: const Text('Edit Profile'),
        ),
      ),
      title: const Text(
        'krishmehtta',
        style: TextStyle(
          color: HevyColors.textPrimary,
          fontSize: DesignTokens.titleMedium,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.ios_share_rounded),
          tooltip: 'Share profile',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () => context.push('/profile/settings'),
        ),
        const SizedBox(width: DesignTokens.spacingXS),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    const chartValues = [3.2, 4.1, 1.1, 3.6, 2.2, 3.5, 3.0, 2.8];
    const chartLabels = [
      'Aug 31',
      'Sep 14',
      'Sep 28',
      'Oct 12',
      'Oct 26',
      'Nov 9',
      'Nov 16',
      'Nov 23',
    ];

    final dashboardItems = [
      _DashboardItem(
        icon: Icons.bar_chart_rounded,
        label: 'Statistics',
        route: '/analytics/statistics',
      ),
      _DashboardItem(
        icon: Icons.fitness_center_rounded,
        label: 'Exercises',
        route: '/exercises',
      ),
      _DashboardItem(
        icon: Icons.straighten_rounded,
        label: 'Measures',
        route: '/profile/measurements',
      ),
      _DashboardItem(
        icon: Icons.calendar_today_rounded,
        label: 'Calendar',
        route: '/profile/settings', // Placeholder route
      ),
    ];

    final workouts = [
      _WorkoutSummary(
        title: 'Legs',
        subtitle: 'Monday, Nov 17, 2025',
        username: 'krishmehtta',
        imageUrl:
            'https://images.unsplash.com/photo-1549068106-b024baf5062?w=400&h=400&fit=crop',
      ),
      _WorkoutSummary(
        title: 'Push Day',
        subtitle: 'Friday, Nov 14, 2025',
        username: 'krishmehtta',
        imageUrl:
            'https://images.unsplash.com/photo-1504593811423-6dd665756598?w=400&h=400&fit=crop',
      ),
    ];

    return SafeArea(
      top: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.paddingScreen,
                vertical: DesignTokens.spacingXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ProfileHeader(),
                  const SizedBox(height: DesignTokens.spacingXL),
                  _SectionHeader(
                    title: '3 hours this week',
                    subtitle: 'Last 3 months',
                    onSubtitleTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  _WeeklyBarChart(
                    values: chartValues,
                    labels: chartLabels,
                    maxValue: 4.5,
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  const _MetricToggle(selected: 'Duration'),
                  const SizedBox(height: DesignTokens.spacingXL),
                  _SectionHeader(
                    title: 'Dashboard',
                    subtitle: null,
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  _DashboardGrid(
                    items: dashboardItems,
                    onTap: (route) {
                      if (route == '/profile/settings') {
                        context.push('/profile/settings');
                      } else {
                        context.push(route);
                      }
                    },
                  ),
                  const SizedBox(height: DesignTokens.spacingXL),
                  _SectionHeader(
                    title: 'Workouts',
                    subtitle: null,
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  _WorkoutList(workouts: workouts),
                  const SizedBox(height: DesignTokens.spacingXL),
                  const SizedBox(height: DesignTokens.spacingXL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 46,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1504593811423-6dd665756598?w=400&h=400&fit=crop',
              ),
            ),
            const SizedBox(width: DesignTokens.spacingL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kris M',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  Row(
                    children: const [
                      Expanded(
                        child: _ProfileStat(label: 'Workouts', value: '91'),
                      ),
                      Expanded(
                        child: _ProfileStat(label: 'Followers', value: '7'),
                      ),
                      Expanded(
                        child: _ProfileStat(label: 'Following', value: '6'),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingS),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'instagram.com/krishmehtta',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: HevyColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: HevyColors.textSecondary,
              ),
        ),
        const SizedBox(height: DesignTokens.spacingXXS),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSubtitleTap;

  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.onSubtitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        if (subtitle != null)
          TextButton.icon(
            onPressed: onSubtitleTap,
            style: TextButton.styleFrom(
              foregroundColor: HevyColors.textSecondary,
              padding: EdgeInsets.zero,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 18),
            label: Text(subtitle!),
          ),
      ],
    );
  }
}

class _WeeklyBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double maxValue;

  const _WeeklyBarChart({
    required this.values,
    required this.labels,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingL,
        vertical: DesignTokens.spacingL,
      ),
      decoration: BoxDecoration(
        color: HevyColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        border: Border.all(color: HevyColors.border),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _AxisLabel('4 hrs'),
                      _AxisLabel('2 hrs'),
                      _AxisLabel('0 hrs'),
                    ],
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingS),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final barWidth = constraints.maxWidth / (values.length * 1.6);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (int i = 0; i < values.length; i++)
                            _ChartBar(
                              value: values[i],
                              maxValue: maxValue,
                              label: labels[i],
                              width: barWidth,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisLabel extends StatelessWidget {
  final String text;

  const _AxisLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: HevyColors.textSecondary,
          ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final String label;
  final double width;

  const _ChartBar({
    required this.value,
    required this.maxValue,
    required this.label,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final heightFactor = (value / maxValue).clamp(0.0, 1.0);
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: heightFactor,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: HevyColors.primary,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusS),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: HevyColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _MetricToggle extends StatelessWidget {
  final String selected;

  const _MetricToggle({required this.selected});

  @override
  Widget build(BuildContext context) {
    final options = ['Duration', 'Volume', 'Reps'];
    return Row(
      children: [
        for (final option in options)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: option == options.last ? 0 : DesignTokens.spacingS,
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingS),
                  backgroundColor:
                      option == selected ? HevyColors.primary : HevyColors.surface,
                  foregroundColor: option == selected
                      ? HevyColors.textPrimary
                      : HevyColors.textSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                  ),
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                child: Text(option),
              ),
            ),
          ),
      ],
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  final List<_DashboardItem> items;
  final ValueChanged<String> onTap;

  const _DashboardGrid({
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: DesignTokens.spacingM,
            mainAxisSpacing: DesignTokens.spacingM,
            childAspectRatio: isCompact ? 1.4 : 1.9,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _DashboardButton(
              icon: item.icon,
              label: item.label,
              onTap: () => onTap(item.route),
            );
          },
        );
      },
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DesignTokens.radiusL),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          border: Border.all(color: HevyColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: HevyColors.textPrimary, size: DesignTokens.iconLarge),
              const Spacer(),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutList extends StatelessWidget {
  final List<_WorkoutSummary> workouts;

  const _WorkoutList({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: workouts
          .map(
            (workout) => Padding(
              padding: EdgeInsets.only(
                bottom: workout == workouts.last ? 0 : DesignTokens.spacingM,
              ),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacingM),
                decoration: BoxDecoration(
                  color: HevyColors.surface,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusL),
                  border: Border.all(color: HevyColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(workout.imageUrl),
                    ),
                    const SizedBox(width: DesignTokens.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.username,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: HevyColors.textSecondary,
                                ),
                          ),
                          const SizedBox(height: DesignTokens.spacingXXS),
                          Text(
                            workout.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: DesignTokens.spacingXXS),
                          Text(
                            workout.subtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: HevyColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz, color: HevyColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DashboardItem {
  final IconData icon;
  final String label;
  final String route;

  _DashboardItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class _WorkoutSummary {
  final String title;
  final String subtitle;
  final String username;
  final String imageUrl;

  _WorkoutSummary({
    required this.title,
    required this.subtitle,
    required this.username,
    required this.imageUrl,
  });
}
