import 'package:flutter_camping_frontend/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/pages/register_page.dart';
import 'package:flutter_camping_frontend/features/home/presentation/pages/detail_camping_site_page.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/pages/prioritas_kriteria_page.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/pages/rekomendasi_page.dart';
import 'package:flutter_camping_frontend/pages/home_page.dart';
import 'package:flutter_camping_frontend/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter_camping_frontend/features/home/presentation/pages/camping_site_page.dart';

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
            path: "/register",
            name: "register",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: RegisterPage(),
                )),
        GoRoute(
            path: "/home",
            name: "homepage",
            pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                )),
        GoRoute(
          // Parent Route: /camping-site/:id
          path: '/camping-site/:id',
          name: 'camping_site',
          builder: (context, state) {
            print(
                "ID dari pathParameters: ${state.pathParameters['id']}"); // Debugging
            final int id = int.parse(state.pathParameters['id']!);
            return CampingSitePage(locationId: id);
          },
          routes: [
            // Child Route: /camping-site/:id/detail
            GoRoute(
              path: 'detail/:campingSiteId',
              name: 'camping_site_detail',
              pageBuilder: (context, state) {
                final int locationId = int.parse(state.pathParameters['id']!);
                final int campingSiteId =
                    int.parse(state.pathParameters['campingSiteId']!);

                return NoTransitionPage(
                  child: DetailCampingSitePage(
                    campingSiteLocationId: locationId,
                    campingSiteId: campingSiteId,
                  ),
                );
              },
            )
          ],
        ),

        // Parent Route: /rekomendasi
        GoRoute(
          path: "/rekomendasi",
          name: "rekomendasi",
          pageBuilder: (context, state) => const NoTransitionPage(
            child: RekomendasiPage(),
          ),
          routes: [
            // Child Route: /rekomendasi/prioritas-kriteria
            GoRoute(
              path: "prioritas-kriteria",
              name: "prioritas_kriteria",
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PrioritasKriteriaPage(),
              ),
            ),
          ],
        ),
      ]);
}
