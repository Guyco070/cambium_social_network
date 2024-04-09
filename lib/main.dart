import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'constants/routes.dart';

void main() {
  runApp(FlutterSizer(
      builder: (context, orientation, screenType) {
      return const ProviderScope(
        child: MyApp(),
      );
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cambium Comments App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}