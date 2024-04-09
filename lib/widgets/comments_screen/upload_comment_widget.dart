import 'package:cambium_social_network/constants/validation_constats.dart';
import 'package:cambium_social_network/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../custom_text_form_field.dart';
import 'upload_comment_button.dart';

class UploadCommentWidget extends StatefulWidget {
  const UploadCommentWidget({super.key, required this.toggleIsShowingContant});
  final void Function() toggleIsShowingContant;

  @override
  State<UploadCommentWidget> createState() => _UploadCommentWidgetState();
}

class _UploadCommentWidgetState extends State<UploadCommentWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Comment comment = const Comment(postId: -1, id: -1, name: '', email: '', body: '');

  bool isShowingContent = false;
  bool isLoading = false;

  String? validateEmail(String? value) {
    final RegExp regex = RegExp(ValidationConstats.emailValidationPattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {    
    void updateComment(Comment newComment) {
      setState(() {
        comment = newComment;
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: widget.toggleIsShowingContant, 
                  icon: Icon(Icons.close, color: Colors.black.withOpacity(0.6),),
                  label: const Text("Close"),
                ),
              ),
            ),
            Form(
              key: _formKey,
              onChanged: () {
                Form.of(primaryFocus!.context!).save();
              },
              child: Column(
                children: [
                  CustomTextFormField(
                    title: "Email", 
                    initialValue: comment.email,
                    onChanged: (value) => updateComment(comment.copyWith(email: value)), 
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    leadingIconData: Icons.mail,
                  ),
                  CustomTextFormField(
                    title: "Post ID (optional)", 
                    initialValue: comment.name,
                    onChanged: (value) => updateComment(comment.copyWith(postId: int.tryParse(value) != null ? -1 : int.parse(value))),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    leadingIconData: Icons.numbers_rounded,
                    validateEmpty: false,
                  ),
                  CustomTextFormField(
                    title: "Name", 
                    initialValue: comment.name,
                    onChanged: (value) => updateComment(comment.copyWith(name: value)),
                    leadingIconData: Icons.person,
                  ),
                  CustomTextFormField(
                    title: "Comment", 
                    initialValue: comment.body,
                    onChanged: (value) => updateComment(comment.copyWith(body: value)), 
                    isMultiline: true, 
                  ),
                ],
              ),
            ),
            UploadCommentButton(comment: comment, validate: () => _formKey.currentState!.validate(), toggleIsShowingContant: widget.toggleIsShowingContant,),
        ],
      ),
    );
  }
}