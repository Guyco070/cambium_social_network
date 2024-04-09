import 'package:cambium_social_network/widgets/comments_screen/comments_shimmer_loading/comment_shimmer_loading_item.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';

class CommentShimmerLoadingList extends StatelessWidget {
  const CommentShimmerLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: AppSizes.topAppBarHeight - 15),
        itemCount: 20,
        itemBuilder: (_, __) => const CommentShimmerLoadingItem(),
    );
  }
}