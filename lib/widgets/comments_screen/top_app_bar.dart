import 'package:cambium_social_network/screens/info_screen.dart';
import 'package:cambium_social_network/widgets/comments_screen/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_sizes.dart';
import '../../models/comment.dart';
import 'comments_search_widget.dart';
import 'upload_comment_widget.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key, required this.updateCommentsToView});
  final Function(List<Comment>) updateCommentsToView;
  
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  bool isAddingComment = false;
  bool isShowingSearch = false;
  bool isShowingOptions = false;

  void toggleIsAddingComment() {
    setState(() {
      isAddingComment = !isAddingComment;
    });
  }

  void toggleIsShowingSearch() {
    setState(() {
      isShowingSearch = !isShowingSearch;
    });
  }

  void toggleIsShowingOptions() {
    setState(() {
      isShowingOptions = !isShowingOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 100.w,
      height: isAddingComment ? 100.h
        : isShowingSearch ?  AppSizes.topAppBarHeight + 20
          : AppSizes.topAppBarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ]
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if(!isAddingComment && !isShowingSearch)
            Row(
              children: [
                IconButton(
                  onPressed: toggleIsShowingOptions, 
                  icon: Icon(
                    isShowingOptions ? Icons.menu_open_sharp : Icons.menu_rounded, 
                    color: isShowingOptions ? Theme.of(context).colorScheme.primary : Colors.black.withOpacity(0.6),
                  ),
                ),
                
                AnimatedSize(
                  duration: const Duration(milliseconds: 600),
                  child: Visibility(
                    visible: isShowingOptions,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: toggleIsShowingSearch, 
                          icon: Icon(Icons.search_rounded, color: Colors.black.withOpacity(0.6),),
                        ),
                        
                        IconButton(
                          onPressed: () => context.push(InfoScreen.routeName), 
                          icon: Icon(Icons.info_outline_rounded, color: Colors.black.withOpacity(0.6),),
                        ),
                    
                        IconButton(
                          onPressed: () => showCustomDialog(context), 
                          icon: Icon(Icons.ads_click_rounded, color: Colors.black.withOpacity(0.6),),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 600),
                      child: !isShowingOptions 
                          ? Container(
                            constraints:  BoxConstraints(maxHeight: AppSizes.topAppBarHeight - 40, maxWidth: 22.w),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 8.0),
                            margin: const EdgeInsets.all(2.0),
                            child: Image.asset(
                              "assets/cambium_name.png",
                              fit: BoxFit.fitHeight,
                            ),
                          )
                          : TextButton.icon(
                        icon: Icon(
                          Icons.add_box_outlined, 
                          color: Colors.black.withOpacity(0.6),
                        ),
                        onPressed: toggleIsAddingComment,
                        label: const Text(
                              "Add Comment",  
                            ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
    
            if(isAddingComment) UploadCommentWidget(toggleIsShowingContant: toggleIsAddingComment,)
            else if(isShowingSearch) CommentsSearchWidget(toggleIsShowingContant: toggleIsShowingSearch, updateCommentsToView: widget.updateCommentsToView,)
          ],
        ),
      )
    );
  }
}
