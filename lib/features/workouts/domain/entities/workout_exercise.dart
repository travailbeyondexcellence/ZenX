import '../../../../core/domain/entity.dart';

/// Workout exercise entity (exercise within a workout)
class WorkoutExercise extends Entity {
  final String id;
  final String workoutId;
  final String exerciseId;
  final int orderIndex;
  final DateTime createdAt;

  const WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.orderIndex,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, workoutId, exerciseId, orderIndex, createdAt];
}









