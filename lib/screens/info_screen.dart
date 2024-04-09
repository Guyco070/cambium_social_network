import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});
  static const String routeName = "/infoScreen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.4),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Info Screen"),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          width: 100.w,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: "Hey, ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: "you got here by using GoRouter !\n\n"
                    ),
      
                    TextSpan(
                      text: "Thanks,\nGuy Cohen"
                    ),
                  ]
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}