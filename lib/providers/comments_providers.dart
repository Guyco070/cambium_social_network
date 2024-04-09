
import 'package:cambium_social_network/controllers/comments_controller.dart';
import 'package:cambium_social_network/models/comment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentProvider = StateNotifierProvider<CommentsController, List<Comment>>((ref) => CommentsController());