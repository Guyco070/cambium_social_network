import 'package:cambium_social_network/screens/comments_screen.dart';
import 'package:cambium_social_network/screens/info_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: CommentsScreen.routeName,
      builder:(context, state) => const CommentsScreen(),
    ),
    GoRoute(
      path: InfoScreen.routeName,
      builder:(context, state) => const InfoScreen(),
    )
  ]);