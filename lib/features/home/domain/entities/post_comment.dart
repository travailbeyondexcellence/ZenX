import '../../../../core/domain/entity.dart';
import '../../../auth/domain/entities/user.dart';

/// Post comment entity
class PostComment extends Entity {
  final String id;
  final String postId;
  final User author;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostComment({
    required this.id,
    required this.postId,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        author,
        content,
        createdAt,
        updatedAt,
      ];
}







