import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Volume analysis screen (Hevy style)
class VolumeAnalysisScreen extends BaseScreen {
  const VolumeAnalysisScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: HevyColors.textPrimary,
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Volume Analysis',
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
    // Mock data - TODO: Replace with actual data
    final weeklyVolume = [
      {'week': 'Week 1', 'volume': 10000.0},
      {'week': 'Week 2', 'volume': 12000.0},
      {'week': 'Week 3', 'volume': 11000.0},
      {'week': 'Week 4', 'volume': 13000.0},
    ];

    return CustomScrollView(
      slivers: [
        // Summary
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This Month',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: DesignTokens.spacingM),
                const Row(
                  children: [
                    Expanded(
                      child: _VolumeStatCard(
                        label: 'Total Volume',
                        value: '46k kg',
                        icon: Icons.trending_up,
                      ),
                    ),
                    SizedBox(width: DesignTokens.spacingM),
                    Expanded(
                      child: _VolumeStatCard(
                        label: 'Average',
                        value: '11.5k kg',
                        icon: Icons.bar_chart,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Chart placeholder
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Card(
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(DesignTokens.paddingScreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Volume Over Time',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: DesignTokens.spacingM),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Chart visualization coming soon',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: HevyColors.textSecondary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Weekly breakdown
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.paddingScreen,
            ),
            child: Text(
              'Weekly Breakdown',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final week = weeklyVolume[index];
              return _VolumeWeekCard(
                week: week['week'] as String,
                volume: week['volume'] as double,
              );
            },
            childCount: weeklyVolume.length,
          ),
        ),
      ],
    );
  }
}

/// Volume stat card
class _VolumeStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _VolumeStatCard({
    required this.label,
    required this.value,
    required this.icon,
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
              color: HevyColors.primary,
              size: DesignTokens.iconMedium, // 24dp
            ),
            const SizedBox(height: DesignTokens.spacingS),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: HevyColors.primary,
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

/// Volume week card
class _VolumeWeekCard extends StatelessWidget {
  final String week;
  final double volume;

  const _VolumeWeekCard({
    required this.week,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: DesignTokens.paddingScreen,
        vertical: DesignTokens.spacingXS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              week,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${(volume / 1000).toStringAsFixed(1)}k kg',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HevyColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
