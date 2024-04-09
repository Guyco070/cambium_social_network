import 'package:cambium_social_network/widgets/comments_screen/bottom_list_item_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import '../../models/comment.dart';
import 'comment_list_item_widget.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView({
    super.key,
    required this.scrollController,
    required this.comments,
    required this.isLoading,
    required this.errorMessage,
  });

  final ScrollController scrollController;
  final List<Comment> comments;
  final bool isLoading;
  final String errorMessage;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  int expandedIndex = -1;

  setIsExpanded(int index) {
    if(expandedIndex == index) {
      expandedIndex = -1;
    } else {
      expandedIndex = index;
    }

    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(10),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: AppSizes.topAppBarHeight - 15),
        controller: widget.scrollController,
        itemCount: widget.comments.length + 1,
        itemBuilder: (_, index) {
          if(index == widget.comments.length) {
            return BottomListItemWidget(isLoading: widget.isLoading, errorMessage: widget.errorMessage);
          }
      
          final Comment comment = widget.comments[index];
          return CommentListItemWidget(key: ValueKey(index), comment: comment, isExpanded: index == expandedIndex, expandComment: () => setIsExpanded(index),);  
        },
      ),
    );
  }
}