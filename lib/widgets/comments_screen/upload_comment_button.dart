import 'dart:math';

import 'package:cambium_social_network/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../models/comment.dart';
import '../../providers/comments_providers.dart';
import '../../services/comments_service.dart';

class UploadCommentButton extends StatelessWidget {
  const UploadCommentButton({
    super.key,
    required this.comment,
    required this.validate,
    this.toggleIsShowingContant,
  });

  final Comment comment;
  final Function()? toggleIsShowingContant;
  final bool Function() validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.topAppBarHeight,
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10, top: 5),
      child: Consumer(
        builder:(context, ref, child) => InkWell(
          onTap: () async {
                final bool validationResult = validate();
                if(validationResult) {
                  final List<Comment> comments = ref.read(commentProvider);
                  Comment commentToUpload = comment;

                  // generate random post id for an empty one
                  if(comment.postId == -1) {
                    final int randomPostId = comments[Random().nextInt(comments.length)].postId;
                    commentToUpload = comment.copyWith(postId: randomPostId);
                  }
                  CommentsService.uploadComment(commentToUpload).then((_) {
                    ref.read(commentProvider.notifier).setData([commentToUpload, ...comments]);
      
                    if(toggleIsShowingContant != null) toggleIsShowingContant!();
                  });
                }
                      
                /* Optimal code for a real api */
                // try {
                //   if(Form.of(primaryFocus!.context!).validate()) {
                //     await CommentsService.uploadComment(comment);
                //     final List<Comment> comments = ref.read(commentProvider);
                //     ref.read(commentProvider.notifier).state = [comment, ...comments];
                //   }
                // } catch(e) {
                //   ScaffoldMessenger.of(context).clearSnackBars();
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Sorry, something went wrong, please try again later"),
                //       behavior: SnackBarBehavior.floating,
                //       width: 90.w,
                //     )
                //   );
                // },
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Comment",
              ),
              const SizedBox(width: 5,),
              Icon(Icons.send_rounded, color: Colors.black.withOpacity(0.6),)
            ],
          ),
        ),
      ),
    );
  }
}