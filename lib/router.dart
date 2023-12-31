import 'package:go_router/go_router.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeScreen.path,
  routes: [
    GoRoute(
      path: HomeScreen.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: DetailsScreen.path,
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
);
