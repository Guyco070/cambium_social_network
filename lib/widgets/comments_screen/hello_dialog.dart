import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 10.h,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            child: const Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "Note: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: "You can click on a comment to expand and see all the information"
                  ),
                ]
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }
  
      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}