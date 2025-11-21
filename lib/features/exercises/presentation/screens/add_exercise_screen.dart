import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Add Exercise screen (Hevy style)
class AddExerciseScreen extends BaseScreen {
  const AddExerciseScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: TextButton(
        onPressed: () => context.pop(),
        child: const Text(
          'Cancel',
          style: TextStyle(color: HevyColors.primary),
        ),
      ),
      title: const Text('Add Exercise'),
      titleTextStyle: const TextStyle(
        fontSize: DesignTokens.titleLarge,
        fontWeight: FontWeight.w600,
        color: HevyColors.textPrimary,
      ),
      backgroundColor: HevyColors.background,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () {
            // TODO: Implement create exercise
            context.push('/exercises/create');
          },
          child: const Text(
            'Create',
            style: TextStyle(color: HevyColors.primary),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // Mock data - in a real app, this would come from state management
    const selectedEquipmentFilter = 'All Equipment';
    const selectedMuscleFilter = 'All Muscles';
    const searchQuery = '';

    final exercises = _generateMockExercises();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(DesignTokens.paddingScreen),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search exercise',
              hintStyle: const TextStyle(color: HevyColors.textSecondary),
              prefixIcon: const Icon(
                Icons.search,
                color: HevyColors.textSecondary,
              ),
              filled: true,
              fillColor: HevyColors.surfaceElevated,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingM,
                vertical: DesignTokens.spacingS,
              ),
            ),
            style: const TextStyle(color: HevyColors.textPrimary),
          ),
        ),

        // Filter buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
          child: Row(
            children: [
              Expanded(
                child: _FilterButton(
                  label: selectedEquipmentFilter,
                  isSelected: selectedEquipmentFilter != null,
                  onTap: () {
                    context.push('/exercises/select-equipment');
                  },
                ),
              ),
              const SizedBox(width: DesignTokens.spacingM),
              Expanded(
                child: _FilterButton(
                  label: selectedMuscleFilter,
                  isSelected: selectedMuscleFilter != null,
                  onTap: () {
                    context.push('/exercises/select-muscle');
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: DesignTokens.spacingS),

        // Exercise list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return _ExerciseListItem(
                exercise: exercise,
                onTap: () {
                  // TODO: Add exercise to workout
                  context.pop(exercise);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<_Exercise> _generateMockExercises() {
    // Generate a large list of mock exercises
    return [
      _Exercise(name: 'Abdominals', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Incline Bench Press (Barbell)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Incline Bench Press (Dumbbell)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Incline Bench Press (Smith Machine)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Incline Chest Fly (Dumbbell)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Incline Chest Press (Machine)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Incline Push Ups', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Inverted Row', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Iso-Lateral Chest Press (Machine)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Iso-Lateral High Row (Machine)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Iso-Lateral Low Row', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Iso-Lateral Row (Machine)', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Jack Knife (Suspension)', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Jackknife Sit Up', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'JM Press (Barbell)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Jump Rope', muscleGroup: 'Cardio', iconAsset: ''),
      _Exercise(name: 'Jump Shrug', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Jump Squat', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Jumping Jack', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Jumping Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Kettlebell Around the World', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Kettlebell Clean', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Kettlebell Curl', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Kettlebell Goblet Squat', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Kettlebell Halo', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Kettlebell High Pull', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Kettlebell Shoulder Press', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Kettlebell Snatch', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Kettlebell Swing', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Kettlebell Turkish Get Up', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Kipping Pull Up', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Knee Raise Parallel Bars', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Kneeling Pulldown (band)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Kneeling Push Up', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'L-Sit Hold', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Landmine 180', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Landmine Row', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Landmine Squat and Press', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Lat Pulldown - Close Grip (Cable)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Lat Pulldown (Band)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Lat Pulldown (Cable)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Lat Pulldown (Machine)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Lateral Band Walks', muscleGroup: 'Glutes', iconAsset: ''),
      _Exercise(name: 'Lateral Box Jump', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Lateral Leg Raises', muscleGroup: 'Glutes', iconAsset: ''),
      _Exercise(name: 'Lateral Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Lateral Raise (Band)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Lateral Raise (Cable)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Lateral Raise (Dumbbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Lateral Raise (Machine)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Lateral Squat', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Leg Extension (Machine)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Leg Press (Machine)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Leg Press Horizontal (Machine)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Leg Raise Parallel Bars', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Low Cable Fly Crossovers', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Low Row (Suspension)', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Lunge (Barbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Lunge (Dumbbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Lying Knee Raise', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Lying Leg Curl (Machine)', muscleGroup: 'Hamstrings', iconAsset: ''),
      _Exercise(name: 'Lying Leg Raise', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Lying Neck Curls', muscleGroup: 'Neck', iconAsset: ''),
      _Exercise(name: 'Lying Neck Curls (Weighted)', muscleGroup: 'Neck', iconAsset: ''),
      _Exercise(name: 'Lying Neck Extension', muscleGroup: 'Neck', iconAsset: ''),
      _Exercise(name: 'Lying Neck Extension (Weighted)', muscleGroup: 'Neck', iconAsset: ''),
      _Exercise(name: 'Meadows Rows (Barbell)', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Mountain Climber', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Muscle Up', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Negative Pull Up', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Nordic Hamstrings Curls', muscleGroup: 'Hamstrings', iconAsset: ''),
      _Exercise(name: 'Oblique Crunch', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'One Arm Push Up', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Overhead Curl (Cable)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Overhead Dumbbell Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Overhead Plate Raise', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Overhead Press (Barbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Overhead Press (Dumbbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Overhead Press (Smith Machine)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Overhead Squat', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Overhead Triceps Extension (Cable)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Partial Glute Bridge (Barbell)', muscleGroup: 'Glutes', iconAsset: ''),
      _Exercise(name: 'Pause Squat (Barbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Pendlay Row (Barbell)', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Pendulum Squat (Machine)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Pike Pushup', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Pilates', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Pinwheel Curl (Dumbbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Pistol Squat', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Plank', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Plank Pushup', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Plate Curl', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Plate Front Raise', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Plate Press', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Plate Squeeze (Svend Press)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Power Clean', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Power Snatch', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Preacher Curl (Barbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Preacher Curl (Dumbbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Preacher Curl (Machine)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Press Under', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Pull Up', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Pull Up (Assisted)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Pull Up (Band)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Pull Up (Weighted)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Pullover (Dumbbell)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Pullover (Machine)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Push Press', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Push Up', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Push Up - Close Grip', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Push Up (Weighted)', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Rack Pull', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Rear Delt Reverse Fly (Cable)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Rear Delt Reverse Fly (Dumbbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Rear Delt Reverse Fly (Machine)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Rear Kick (Machine)', muscleGroup: 'Glutes', iconAsset: ''),
      _Exercise(name: 'Renegade Row (Dumbbell)', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Reverse Bar Grip Triceps', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Reverse Crunch', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Reverse Curl (Barbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Reverse Curl (Cable)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Reverse Curl (Dumbbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Reverse Fly Single Arm (Cable)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Reverse Grip Concentration Curl', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Reverse Grip Lat Pulldown (Cable)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Reverse Hyperextension', muscleGroup: 'Glutes', iconAsset: ''),
      _Exercise(name: 'Reverse Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Reverse Lunge (Barbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Reverse Lunge (Dumbbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Reverse Plank', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Ring Dips', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Ring Pull Up', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Ring Push Up', muscleGroup: 'Chest', iconAsset: ''),
      _Exercise(name: 'Romanian Deadlift (Barbell)', muscleGroup: 'Hamstrings', iconAsset: ''),
      _Exercise(name: 'Romanian Deadlift (Dumbbell)', muscleGroup: 'Hamstrings', iconAsset: ''),
      _Exercise(name: 'Rope Cable Curl', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Rope Straight Arm Pulldown', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Rowing Machine', muscleGroup: 'Cardio', iconAsset: ''),
      _Exercise(name: 'Running', muscleGroup: 'Cardio', iconAsset: ''),
      _Exercise(name: 'T Bar Row', muscleGroup: 'Upper Back', iconAsset: ''),
      _Exercise(name: 'Thruster (Barbell)', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Thruster (Kettlebell)', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Toe Touch', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Toes to Bar', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Torso Rotation', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Treadmill', muscleGroup: 'Cardio', iconAsset: ''),
      _Exercise(name: 'Triceps Dip', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Dip (Assisted)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Dip (Weighted)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Extension (Barbell)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Extension (Cable)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Extension (Dumbbell)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Extension (Machine)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Extension (Suspension)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Kickback (Cable)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Kickback (Dumbbell)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Pressdown', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Pushdown', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Triceps Rope Pushdown', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Upright Row (Barbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Upright Row (Cable)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'Upright Row (Dumbbell)', muscleGroup: 'Shoulders', iconAsset: ''),
      _Exercise(name: 'V Up', muscleGroup: 'Abdominals', iconAsset: ''),
      _Exercise(name: 'Vertical Traction (Machine)', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Waiter Curl (Dumbbell)', muscleGroup: 'Biceps', iconAsset: ''),
      _Exercise(name: 'Walking', muscleGroup: 'Cardio', iconAsset: ''),
      _Exercise(name: 'Walking Lunge', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Walking Lunge (Dumbbell)', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Wall Ball', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Wall Sit', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Wide Pull Up', muscleGroup: 'Lats', iconAsset: ''),
      _Exercise(name: 'Wide-Elbow Triceps Press (Dumbbell)', muscleGroup: 'Triceps', iconAsset: ''),
      _Exercise(name: 'Wrist Roller', muscleGroup: 'Forearms', iconAsset: ''),
      _Exercise(name: 'Yoga', muscleGroup: 'Full Body', iconAsset: ''),
      _Exercise(name: 'Zercher Squat', muscleGroup: 'Quadriceps', iconAsset: ''),
      _Exercise(name: 'Zottman Curl (Dumbbell)', muscleGroup: 'Biceps', iconAsset: ''),
    ];
  }
}

class _Exercise {
  final String name;
  final String muscleGroup;
  final String iconAsset;

  _Exercise({
    required this.name,
    required this.muscleGroup,
    required this.iconAsset,
  });
}

class _ExerciseListItem extends StatelessWidget {
  final _Exercise exercise;
  final VoidCallback onTap;

  const _ExerciseListItem({
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingS),
        child: Row(
          children: [
            // Exercise icon
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: HevyColors.surfaceElevated,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center,
                color: HevyColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: DesignTokens.spacingM),
            // Exercise name and muscle group
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: DesignTokens.bodyLarge,
                      fontWeight: FontWeight.w500,
                      color: HevyColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    exercise.muscleGroup,
                    style: const TextStyle(
                      fontSize: DesignTokens.bodySmall,
                      color: HevyColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Chart icon
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: HevyColors.surfaceElevated,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.trending_up,
                color: HevyColors.textSecondary,
                size: DesignTokens.iconSmall, // 16dp (closest to 18)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingM,
          vertical: DesignTokens.spacingS,
        ),
        decoration: BoxDecoration(
          color: isSelected ? HevyColors.surfaceElevated : HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          border: Border.all(
            color: isSelected ? HevyColors.primary : HevyColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.bodyMedium,
              color: isSelected ? HevyColors.textPrimary : HevyColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

