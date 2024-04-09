import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comment.dart';
import '../../providers/comments_providers.dart';
import '../custom_text_form_field.dart';

class CommentsSearchWidget extends ConsumerStatefulWidget {
  const CommentsSearchWidget({super.key, required this.toggleIsShowingContant, required this.updateCommentsToView});
  final void Function() toggleIsShowingContant;
  final Function(List<Comment>) updateCommentsToView;
  

  @override
  ConsumerState<CommentsSearchWidget> createState() => _CommentsSearchWidgetState();
}

class _CommentsSearchWidgetState extends ConsumerState<CommentsSearchWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(
      () {
        final String value = _textEditingController.text;
        widget.updateCommentsToView(ref.read(commentProvider).where((element) => element.name.contains(value) || element.email.contains(value)).toList());
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmptyText = _textEditingController.text.isEmpty;
    return  Row(
      children: [
        IconButton(
          onPressed: () {
            widget.updateCommentsToView(ref.read(commentProvider));
            widget.toggleIsShowingContant();
          }, 
          icon: Icon(
            Icons.arrow_drop_up_rounded,
            color: Colors.black.withOpacity(0.6),
          )
        ),
        
        CustomTextFormField(
          textEditingController: _textEditingController,
          title: "Comment Name/ Email",
          trailingWidget: IconButton(
            onPressed: isEmptyText
              ? null
              : () {
                _textEditingController.clear();
              }, 
            icon: Icon(isEmptyText ? Icons.search_rounded : Icons.close)
          ),
        ),
      ],
    );
  }
}