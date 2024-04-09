import 'dart:convert';

import 'package:cambium_social_network/constants/api_constants.dart';
import 'package:cambium_social_network/models/comment.dart';
import 'package:dio/dio.dart';

class CommentsService {
  static int nextPage = 1;
  
  static String get nextCommentsEndpoint => "${ApiConstants.fetchBaseUrl}/comments?_page=${nextPage.toString()}&_limit=${ApiConstants.commentsFetchLimit}";

  static Future<List<Comment>> fetchData() async {
    final Dio dio = Dio();
    final Response response = await dio.get(nextCommentsEndpoint);
    
    if(response.statusCode == 200) {
      final List<Comment> result = (response.data as List).map((e) => Comment.fromJson(e)).toList();
      nextPage++;
      return result;
    } else {
      throw Exception(response);     
    }
  }

  static Future<void> uploadComment(Comment newComment) async {
    final Dio dio = Dio();
    try {
      // ignore: unused_local_variable
      final Response response = await dio.post(
        ApiConstants.postCommentEndpoint,
        data: jsonEncode(newComment.toJson()),
      );

      // if(response.statusCode == 200) {
      print("Comment Has Uploaded Successfully !");
      // } else {
        // throw Exception(response);     
      // }
    } catch (e) {
      // throw Exception(response);   
    }
  }
}