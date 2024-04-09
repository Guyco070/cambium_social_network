import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentShimmerLoadingItem extends StatelessWidget {
  const CommentShimmerLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white,
      ),
      child: Card(
        color: Colors.grey.withOpacity(0.3),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        child: ListTile(
          title: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  "name", 
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Text(
                "Post: 1",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1),
              Text(
                "The comment body will be here\nand here is the second line", 
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
          trailing: CircleAvatar(
              radius: 2.h,
              child: const Text("A"),
            ),
        ),
      ),
    );
  }
}