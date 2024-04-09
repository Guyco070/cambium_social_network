import 'package:flutter/material.dart';

import '../error_message_widget.dart';
import '../loading_widget.dart';

class BottomListItemWidget extends StatelessWidget {
  const BottomListItemWidget({super.key, required this.isLoading, required this.errorMessage});
  final bool isLoading;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: LoadingWidget()) 
      : errorMessage.isNotEmpty ? ErrorMessageWidget(errorMessage: errorMessage)
      : const SizedBox.shrink();
  }
}