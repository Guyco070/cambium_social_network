import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/comment.dart';

class CommentListItemWidget extends StatelessWidget {
  const CommentListItemWidget({
    required super.key,
    required this.comment,
    required this.expandComment,
    this.isExpanded = false,
  });

  final Comment comment;
  final bool isExpanded;
  final void Function() expandComment;

  Widget _buildSmallTextWidget(String text) {
    return Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 10
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final int index = (key as ValueKey).value;
    
    return GestureDetector(
      onTap: expandComment,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
        child: Card(
          color: Colors.grey.withOpacity(isExpanded ? 1 : 0.6),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    _buildSmallTextWidget("${(key as ValueKey).value + 1}"),
                    const Spacer(),
                    if(comment.id == -1)
                      Shimmer.fromColors(
                      enabled: !isExpanded && index == 0, // for a new comment
                      baseColor: Colors.white.withOpacity(0.8),
                      highlightColor: Colors.black,
                      period: const Duration(seconds: 4),
                      child: _buildSmallTextWidget("Created by you")
                    ),
                  ],
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        comment.name, 
                        maxLines: isExpanded ? null : 1,
                        overflow: isExpanded ? null :TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: isExpanded ? FontWeight.bold : null
                        ),
                      ),
                    ),
                    if(isExpanded)
                        CircleAvatar(
                        child: Text(comment.email.characters.first.toUpperCase()),
                      ) else _buildSmallTextWidget("Post: ${comment.postId}"),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(thickness: 1),
                      Text(
                        comment.body, 
                        maxLines: isExpanded ? null : 2,
                        overflow: isExpanded ? null :TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white.withOpacity(isExpanded ? 1 : 0.8)),
                      ),
                      if(isExpanded) 
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              _buildSmallTextWidget("Nickname: ${comment.nickName}"),
                              const Spacer(),
                              _buildSmallTextWidget("Post: ${comment.postId}"),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                trailing: isExpanded 
                  ? null 
                  : CircleAvatar(
                    radius: 2.h,
                    child: Text(comment.email.characters.first.toUpperCase()),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}