import '../../../../core/domain/entity.dart';

/// Exercise entity
class Exercise extends Entity {
  final String id;
  final String name;
  final String? description;
  final String? category;
  final String? primaryMuscleGroup;
  final List<String> secondaryMuscleGroups;
  final String? equipmentRequired;
  final String? difficultyLevel;
  final bool isCustom;
  final String? createdBy;
  final DateTime createdAt;

  const Exercise({
    required this.id,
    required this.name,
    this.description,
    this.category,
    this.primaryMuscleGroup,
    this.secondaryMuscleGroups = const [],
    this.equipmentRequired,
    this.difficultyLevel,
    this.isCustom = false,
    this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        primaryMuscleGroup,
        secondaryMuscleGroups,
        equipmentRequired,
        difficultyLevel,
        isCustom,
        createdBy,
        createdAt,
      ];
}









