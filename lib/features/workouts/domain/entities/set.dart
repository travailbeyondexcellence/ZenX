import '../../../../core/domain/entity.dart';

/// Set entity (rep set within a workout exercise)
class Set extends Entity {
  final String id;
  final String workoutExerciseId;
  final int setNumber;
  final int? reps;
  final double? weightKg;
  final double? rpe; // Rate of Perceived Exertion (1-10)
  final String? notes;
  final bool completed;
  final DateTime createdAt;

  const Set({
    required this.id,
    required this.workoutExerciseId,
    required this.setNumber,
    this.reps,
    this.weightKg,
    this.rpe,
    this.notes,
    this.completed = false,
    required this.createdAt,
  });

  /// Calculate volume (reps * weight)
  double? get volume {
    if (reps == null || weightKg == null) return null;
    return reps! * weightKg!;
  }

  @override
  List<Object?> get props => [
        id,
        workoutExerciseId,
        setNumber,
        reps,
        weightKg,
        rpe,
        notes,
        completed,
        createdAt,
      ];
}









