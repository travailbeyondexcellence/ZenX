import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Create workout screen (Hevy style)
class CreateWorkoutScreen extends BaseScreen {
  const CreateWorkoutScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close),
        color: HevyColors.textPrimary,
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'New Workout',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // TODO: Save workout and start
            context.push('/workouts/active');
          },
          child: const Text(
            'Start',
            style: TextStyle(
              color: HevyColors.primary,
              fontSize: DesignTokens.bodyMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Workout name input
          TextField(
            decoration: const InputDecoration(
              labelText: 'Workout Name',
              hintText: 'e.g., Push Day, Leg Day',
              prefixIcon: Icon(Icons.fitness_center),
            ),
            onChanged: (value) {
              // TODO: Update workout name
            },
          ),
          const SizedBox(height: DesignTokens.spacingL),

          // Quick templates section
          Text(
            'Quick Start',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: DesignTokens.spacingM),
          Wrap(
            spacing: DesignTokens.spacingS,
            runSpacing: DesignTokens.spacingS,
            children: [
              _TemplateChip(
                label: 'Push',
                icon: Icons.trending_up,
                onTap: () {
                  // TODO: Load push template
                },
              ),
              _TemplateChip(
                label: 'Pull',
                icon: Icons.trending_down,
                onTap: () {
                  // TODO: Load pull template
                },
              ),
              _TemplateChip(
                label: 'Legs',
                icon: Icons.directions_walk,
                onTap: () {
                  // TODO: Load legs template
                },
              ),
              _TemplateChip(
                label: 'Full Body',
                icon: Icons.accessibility_new,
                onTap: () {
                  // TODO: Load full body template
                },
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingXL),

          // Add exercise button
          OutlinedButton.icon(
            onPressed: () {
              context.push('/exercises');
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Exercise'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingL),

          // Recent workouts section
          Text(
            'Recent Workouts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: DesignTokens.spacingM),
          _RecentWorkoutCard(
            name: 'Push Day',
            date: DateTime.now().subtract(const Duration(days: 2)),
            exercises: const ['Bench Press', 'Shoulder Press', 'Triceps'],
            onTap: () {
              // TODO: Load workout template
            },
          ),
          const SizedBox(height: DesignTokens.spacingS),
          _RecentWorkoutCard(
            name: 'Pull Day',
            date: DateTime.now().subtract(const Duration(days: 4)),
            exercises: const ['Deadlift', 'Rows', 'Biceps'],
            onTap: () {
              // TODO: Load workout template
            },
          ),
        ],
      ),
    );
  }
}

/// Template chip widget
class _TemplateChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _TemplateChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.paddingM,
          vertical: DesignTokens.spacingS,
        ),
        decoration: BoxDecoration(
          color: HevyColors.surfaceElevated,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          border: Border.all(color: HevyColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: DesignTokens.iconSmall, // 16dp (closest to 18)
              color: HevyColors.primary,
            ),
            const SizedBox(width: DesignTokens.spacingXS),
            Text(label),
          ],
        ),
      ),
    );
  }
}

/// Recent workout card
class _RecentWorkoutCard extends StatelessWidget {
  final String name;
  final DateTime date;
  final List<String> exercises;
  final VoidCallback onTap;

  const _RecentWorkoutCard({
    required this.name,
    required this.date,
    required this.exercises,
    required this.onTap,
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _getTimeAgo(date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacingS),
              Wrap(
                spacing: DesignTokens.spacingXS,
                runSpacing: DesignTokens.spacingXS,
                children: exercises.map((exercise) {
                  return Chip(
                    label: Text(
                      exercise,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: HevyColors.surfaceElevated,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
