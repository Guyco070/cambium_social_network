import 'package:cambium_social_network/models/comment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CommentsController extends StateNotifier<List<Comment>> {
  CommentsController(): super([]);

  setData(List<Comment> newData) {
    state = [...newData];
  }

  addAll(List<Comment> newData) {
    state = [...state, ...newData];
  }

  insertFirst(Comment newData) {
    state = [newData, ...state];
  }
}