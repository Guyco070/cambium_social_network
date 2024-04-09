import 'package:cambium_social_network/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.validator,
    this.onChanged,
    this.isMultiline = false,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.leadingIconData,
    this.validateEmpty = true, 
    this.trailingWidget,
    this.textEditingController,
  });

  final String title;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final bool isMultiline;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final IconData? leadingIconData;
  final Widget? trailingWidget;
  final bool validateEmpty;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: AppSizes.topAppBarHeight,
      constraints: BoxConstraints(minHeight: isMultiline ? 15.h : 50, maxHeight: isMultiline ? 15.h : double.infinity),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        maxLines: isMultiline ? 100 : 1,
        autofocus: true,
        initialValue: initialValue,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: leadingIconData !=null ? Icon(leadingIconData) : null,
          suffixIcon: trailingWidget,
          hintText: "Enter $title",
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
        ),
        validator: (value) {
          if(value!.isEmpty && validateEmpty) return "$title field cannot be empty";
          if(validator != null) return validator!(value);
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}