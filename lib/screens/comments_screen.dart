import 'package:cambium_social_network/providers/comments_providers.dart';
import 'package:cambium_social_network/services/comments_service.dart';
import 'package:cambium_social_network/widgets/comments_screen/comments_shimmer_loading/comments_shimmer_loading_list.dart';
import 'package:cambium_social_network/widgets/error_message_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../models/comment.dart';
import 'package:flutter/material.dart';
import '../widgets/comments_screen/comments_list_view.dart';
import '../widgets/comments_screen/top_app_bar.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  const CommentsScreen({super.key,});
  static const String routeName = "/";

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final Future future = CommentsService.fetchData();
  final ScrollController _scrollController = ScrollController();
  final List<Comment> allComments = [];
  final List<Comment> commentsToView = [];
  
  bool isLoading = false;
  String errorMessage = '';
  bool showScrollToTopFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  scrollListener() {
    if(isLoading) return;
    final double pixels = _scrollController.position.pixels;
    if(pixels >= _scrollController.position.maxScrollExtent - 40) {
      setState(() {
        isLoading = true;
      });
      fetchMoreData();
    }

    else if(pixels <= 50.h && showScrollToTopFloatingButton) {
      setState(() {
          showScrollToTopFloatingButton = false;
        });
    } else if(pixels > 50.h) {
        setState(() {
          showScrollToTopFloatingButton = true;
        });
    } 
  }
  
  Future<void> fetchMoreData() async {
      try {
        final List<Comment> newComments = await CommentsService.fetchData();
        allComments.addAll(newComments);
        ref.read(commentProvider.notifier).setData(allComments);
        setCommentsToView(allComments, rerender: false);
        isLoading = false;
      } catch(e) {
        setState((){
          isLoading = false;
          errorMessage = "Sorry, somthing went wrong.";
        });
      }
    }

  setComments(List<Comment> newComments) {
    if(newComments.isNotEmpty && allComments.length != newComments.length){
      allComments.clear();
      allComments.addAll(newComments);
      setCommentsToView(allComments);
      animateToTop();
    }
  }

  setCommentsToView(List<Comment> newComments, {bool rerender = true}) {
    commentsToView.clear();
    commentsToView.addAll(newComments);
    if(rerender) setState(() {});
  }

  animateToTop() {
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context,) {
    setComments(ref.watch(commentProvider));
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: !showScrollToTopFloatingButton 
          ? null 
          : FloatingActionButton(
            onPressed: animateToTop, 
            child: const Icon(Icons.arrow_upward_rounded),
          ),
        body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(allComments.isEmpty) {
                allComments.addAll(snapshot.data);
                commentsToView.addAll(snapshot.data);
                ref.read(commentProvider).addAll(allComments);
              }
              
              return Stack(
                children: [
                  if(commentsToView.isNotEmpty) CommentsListView(scrollController: _scrollController, comments: commentsToView, isLoading: isLoading, errorMessage: errorMessage)
                  else const Center(
                    child: Text( 
                    "No Comment that match.\nTry Somthing Else...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),

                  TopAppBar(updateCommentsToView: setCommentsToView,),
                ],
              );
            }
        
            if(snapshot.hasError) return ErrorMessageWidget(errorMessage: snapshot.error.toString()); 
        
            return const CommentShimmerLoadingList();
          }
        ),
      ),
    ); 
  }
}
