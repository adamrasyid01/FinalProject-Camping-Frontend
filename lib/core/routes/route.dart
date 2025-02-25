import 'package:flutter_camping_frontend/pages/home_page.dart';
import 'package:flutter_camping_frontend/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

class RouteCamping {
  get router => GoRouter(initialLocation: "/", routes: [
        GoRoute(
            path: "/",
            name: "splash_screen",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: SplashScreen(),
                )),
        GoRoute(
            path: "/home",
            name: "homepage",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ))
      ]);
}
