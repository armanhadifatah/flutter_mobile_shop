import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mobile_shop/src/features/authentication/data/auth_repository.dart';
import 'package:mobile_shop/src/features/authentication/presentation/sign_in/phone_sign_in_screen.dart';
import 'package:mobile_shop/src/features/categories/presentation/category_list.dart';
import 'package:mobile_shop/src/features/profile/presentation/profile_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../configs/hive_box.dart';
import '../features/favorite/presentation/favorite_list_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/products/presentation/products_list/products_list_screen.dart';
import 'go_router_refresh_stream.dart';
import 'main.dart';
import 'not_found_screen.dart';
import 'welcome_screen.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  favorite,
  orders,
  profile,
  signIn,
  categories,
  welcome
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,

    // * redirect logic based on the authentication state
    redirect: (context, state) async {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/home';
        }
      } else {
        // check hive if user has seen the welcome screen
        // if not, redirect to welcome screen
        final box = await Hive.openBox(HiveBoxes.app);
        if (box.isEmpty) {
          return '/welcome';
        }
        final isWelcomeScreenSeen =
            box.get(HiveBoxes.isWelcomeScreenSeen, defaultValue: false);

        if (!isWelcomeScreenSeen) {
          return '/welcome';
        }

        if (state.location == '/account' || state.location == '/orders') {
          return '/home';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          // first branch (A)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/home',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProductsListScreen(),
                ),
                routes: const [],
              ),
            ],
          ),
          // second branch (B)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/favorite',
                name: AppRoute.favorite.name,
                builder: (context, state) => FavoriteListScreen(),
                routes: const [
                  // child route
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (context, state) => const FavoriteScreen(),
                  // ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/categories',
                name: AppRoute.categories.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CategoriesScreen(),
                ),
                routes: const [
                  // child route
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (context, state) => const FavoriteScreen(),
                  // ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
                routes: const [
                  // child route
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (context, state) => const FavoriteScreen(),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/product/:id',
        name: AppRoute.product.name,
        parentNavigatorKey: _rootNavigatorKey,
        // pageBuilder: (context, state) {
        //   final productId = state.pathParameters['id']!;
        //   return NoTransitionPage(child: ProductScreen(productId: productId));
        // },
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductScreen(productId: productId);
        },
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        builder: (context, state) => const PhoneSignInScreen(),
      ),
      GoRoute(
        path: '/welcome',
        name: AppRoute.welcome.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: WelcomeScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
