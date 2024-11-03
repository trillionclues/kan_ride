import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../features/splash/splash_screen.dart';
import '../config/app_client_config_page.dart';
import '../routing/not_found_screen.dart';
import '../routing/route_paths.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.appClientConfig.name,
        builder: (context, state) => const AppClientConfigPage(),
      ),
      GoRoute(path: '/splash',name: AppRoute.splash.name,
      builder: (context, state) => const SplashPage(),
      )
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}

final goRouterProvider = Provider((ref) => goRouter());