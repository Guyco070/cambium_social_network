
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const Comment._();
  const factory Comment({
    required int postId,
    required int id,
    required String name,
    required String email,
    required String body,
  }) = _Comment;

  String get nickName {
    final List<String> splitedEmail = email.split("@");
    if(splitedEmail.isEmpty) return '';
    return splitedEmail[0];
  }

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}