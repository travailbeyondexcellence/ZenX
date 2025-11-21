import '../../../../core/domain/entity.dart';
import '../../../workouts/domain/entities/workout.dart';
import '../../../auth/domain/entities/user.dart';

/// Workout post entity - combines workout with social features
class WorkoutPost extends Entity {
  final String id;
  final String workoutId;
  final Workout workout;
  final User author;
  final String? imageUrl;
  final String? caption;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final List<String> likedByUserIds; // First few user IDs who liked
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkoutPost({
    required this.id,
    required this.workoutId,
    required this.workout,
    required this.author,
    this.imageUrl,
    this.caption,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    this.likedByUserIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        workoutId,
        workout,
        author,
        imageUrl,
        caption,
        likesCount,
        commentsCount,
        isLiked,
        likedByUserIds,
        createdAt,
        updatedAt,
      ];
}







