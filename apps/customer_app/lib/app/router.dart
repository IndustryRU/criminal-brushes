import 'package:criminal_brushes/app/app_shell.dart';
import 'package:criminal_brushes/features/home/presentation/home_screen.dart';
import 'package:criminal_brushes/features/shared/presentation/placeholder_screen.dart';
import 'package:criminal_brushes/features/ui_kit/presentation/ui_kit_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/catalog',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Catalog',
            description: 'Mock product grid lands here in Milestone 2.',
          ),
        ),
        GoRoute(
          path: '/product/:slug',
          builder: (context, state) => PlaceholderScreen(
            title: 'Product details',
            description:
                'Product slug: ${state.pathParameters['slug'] ?? 'unknown'}.',
          ),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Cart',
            description: 'Local cart controller and totals are ready for UI.',
            primaryPath: '/catalog',
            primaryLabel: 'Browse catalog',
          ),
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Checkout',
            description: 'Mock checkout form starts after cart UI.',
          ),
        ),
        GoRoute(
          path: '/order/confirmation',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Confirmation',
            description: 'Demo order success state placeholder.',
            primaryPath: '/',
            primaryLabel: 'Back home',
          ),
        ),
        GoRoute(
          path: '/ui-kit',
          builder: (context, state) => const UiKitScreen(),
        ),
      ],
    ),
  ],
);
