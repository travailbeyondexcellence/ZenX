import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Exercise library screen with search and categories (Hevy style)
class ExerciseLibraryScreen extends BaseScreen {
  const ExerciseLibraryScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      title: const Text(
        'Exercise Library',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: HevyColors.textPrimary,
          onPressed: () {
            context.push('/exercises/create');
          },
          tooltip: 'Create Custom Exercise',
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search exercises...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Show filter dialog
                },
              ),
            ),
            onChanged: (value) {
              // TODO: Filter exercises
            },
          ),
        ),

        // Category chips
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            children: const [
              _CategoryChip(label: 'All', isSelected: true),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Chest'),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Back'),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Legs'),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Shoulders'),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Arms'),
              SizedBox(width: DesignTokens.spacingXS),
              _CategoryChip(label: 'Core'),
            ],
          ),
        ),

        const Divider(height: 1),

        // Exercise list
        Expanded(
          child: _ExerciseList(),
        ),
      ],
    );
  }
}

/// Category chip widget
class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryChip({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Filter by category
      },
      selectedColor: HevyColors.primary.withValues(alpha: 0.2),
      checkmarkColor: HevyColors.primary,
    );
  }
}

/// Exercise list widget
class _ExerciseList extends StatelessWidget {
  // Mock data - TODO: Replace with actual data from database
  final List<ExerciseItem> _exercises = [
    ExerciseItem(
      id: '1',
      name: 'Bench Press',
      category: 'Chest',
      muscleGroup: 'Chest',
      equipment: 'Barbell',
    ),
    ExerciseItem(
      id: '2',
      name: 'Squat',
      category: 'Legs',
      muscleGroup: 'Quadriceps',
      equipment: 'Barbell',
    ),
    ExerciseItem(
      id: '3',
      name: 'Deadlift',
      category: 'Back',
      muscleGroup: 'Back',
      equipment: 'Barbell',
    ),
    ExerciseItem(
      id: '4',
      name: 'Shoulder Press',
      category: 'Shoulders',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbell',
    ),
    ExerciseItem(
      id: '5',
      name: 'Bicep Curl',
      category: 'Arms',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbell',
    ),
    ExerciseItem(
      id: '6',
      name: 'Plank',
      category: 'Core',
      muscleGroup: 'Core',
      equipment: 'Bodyweight',
    ),
  ];

  _ExerciseList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.paddingScreen),
      itemCount: _exercises.length,
      itemBuilder: (context, index) {
        final exercise = _exercises[index];
        return _ExerciseCard(
          exercise: exercise,
          onTap: () {
            context.push('/exercises/${exercise.id}');
          },
        );
      },
    );
  }
}

/// Exercise card widget
class _ExerciseCard extends StatelessWidget {
  final ExerciseItem exercise;
  final VoidCallback onTap;

  const _ExerciseCard({
    required this.exercise,
    required this.onTap,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'chest':
        return HevyColors.categoryChest;
      case 'back':
        return HevyColors.categoryBack;
      case 'legs':
        return HevyColors.categoryLegs;
      case 'shoulders':
        return HevyColors.categoryShoulders;
      case 'arms':
        return HevyColors.categoryArms;
      case 'core':
        return HevyColors.categoryCore;
      default:
        return HevyColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacingM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: Row(
            children: [
              // Category indicator
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: _getCategoryColor(exercise.category),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingM),
              // Exercise info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: DesignTokens.spacingXXS),
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          size: DesignTokens.iconSmall, // 16dp (closest to 14)
                          color: HevyColors.textSecondary,
                        ),
                        const SizedBox(width: DesignTokens.spacingXXS),
                        Text(
                          exercise.muscleGroup,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: DesignTokens.spacingS),
                        const Icon(
                          Icons.sports_gymnastics,
                          size: DesignTokens.iconSmall, // 16dp (closest to 14)
                          color: HevyColors.textSecondary,
                        ),
                        const SizedBox(width: DesignTokens.spacingXXS),
                        Text(
                          exercise.equipment,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Arrow
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

/// Exercise item model (temporary)
class ExerciseItem {
  final String id;
  final String name;
  final String category;
  final String muscleGroup;
  final String equipment;

  ExerciseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.muscleGroup,
    required this.equipment,
  });
}
