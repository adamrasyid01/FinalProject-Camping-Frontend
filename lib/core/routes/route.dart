import 'package:flutter_camping_frontend/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_camping_frontend/pages/home_page.dart';
import 'package:flutter_camping_frontend/features/splash/presentation/pages/splash_screen.dart';

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
            path: "/login",
            name: "login",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: LoginPage(),
                )),  
        GoRoute(
            path: "/home",
            name: "homepage",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ))
      ]);
}
