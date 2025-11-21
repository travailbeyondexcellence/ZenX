import '../../../../core/domain/entity.dart';

/// Workout entity
class Workout extends Entity {
  final String id;
  final String userId;
  final String? name;
  final String? notes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? durationSeconds;
  final double? totalVolumeKg;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Workout({
    required this.id,
    required this.userId,
    this.name,
    this.notes,
    this.startedAt,
    this.completedAt,
    this.durationSeconds,
    this.totalVolumeKg,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Check if workout is active
  bool get isActive => startedAt != null && completedAt == null;

  /// Check if workout is completed
  bool get isCompleted => completedAt != null;

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        notes,
        startedAt,
        completedAt,
        durationSeconds,
        totalVolumeKg,
        createdAt,
        updatedAt,
      ];
}









