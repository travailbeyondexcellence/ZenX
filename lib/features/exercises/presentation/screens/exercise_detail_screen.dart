import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Exercise detail screen (Hevy style)
class ExerciseDetailScreen extends BaseScreen {
  final String exerciseId;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseId,
  });

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
        'Exercise Details',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: HevyColors.textPrimary,
          onPressed: () {
            // TODO: Show exercise options (edit, delete)
          },
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // Mock data - TODO: Replace with actual data
    const exerciseName = 'Bench Press';
    const category = 'Chest';
    const muscleGroup = 'Chest';
    const equipment = 'Barbell';
    const description = 'A compound exercise targeting the chest, shoulders, and triceps.';

    return CustomScrollView(
      slivers: [
        // Exercise info
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: DesignTokens.spacingM),
                Wrap(
                  spacing: DesignTokens.spacingS,
                  runSpacing: DesignTokens.spacingS,
                  children: [
                    _InfoChip(
                      icon: Icons.fitness_center,
                      label: muscleGroup,
                    ),
                    _InfoChip(
                      icon: Icons.sports_gymnastics,
                      label: equipment,
                    ),
                    _InfoChip(
                      icon: Icons.category,
                      label: category,
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingL),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: DesignTokens.spacingS),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),

        // Personal records
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.paddingScreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Records',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: DesignTokens.spacingM),
                const _PRRow(label: '1RM', value: '100 kg'),
                const SizedBox(height: DesignTokens.spacingS),
                const _PRRow(label: 'Max Reps', value: '12'),
                const SizedBox(height: DesignTokens.spacingS),
                const _PRRow(label: 'Max Volume', value: '1200 kg'),
              ],
            ),
          ),
        ),

        // Recent workouts
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Workouts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: DesignTokens.spacingM),
                _RecentWorkoutRow(
                  date: DateTime.now().subtract(const Duration(days: 2)),
                  sets: '3 sets',
                  volume: '210 kg',
                ),
                const SizedBox(height: DesignTokens.spacingS),
                _RecentWorkoutRow(
                  date: DateTime.now().subtract(const Duration(days: 5)),
                  sets: '3 sets',
                  volume: '200 kg',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Info chip widget
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        icon,
        size: DesignTokens.iconSmall, // 16dp
      ),
      label: Text(label),
      backgroundColor: HevyColors.surfaceElevated,
    );
  }
}

/// PR row widget
class _PRRow extends StatelessWidget {
  final String label;
  final String value;

  const _PRRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: HevyColors.accentOrange,
                  size: DesignTokens.iconSmall, // 16dp (small inline icon)
                ),
                const SizedBox(width: DesignTokens.spacingS),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HevyColors.accentOrange,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Recent workout row
class _RecentWorkoutRow extends StatelessWidget {
  final DateTime date;
  final String sets;
  final String volume;

  const _RecentWorkoutRow({
    required this.date,
    required this.sets,
    required this.volume,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Navigate to workout detail
        },
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(date),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                children: [
                  Text(
                    sets,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: DesignTokens.spacingM),
                  Text(
                    volume,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: DesignTokens.spacingS),
                  const Icon(
                    Icons.chevron_right,
                    size: DesignTokens.iconSmall, // 16dp
                    color: HevyColors.textTertiary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
