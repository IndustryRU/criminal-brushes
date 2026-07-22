import 'package:criminal_brushes/app/app_shell.dart';
import 'package:criminal_brushes/features/cart/application/cart_controller.dart';
import 'package:criminal_brushes/features/catalog/application/product_providers.dart';
import 'package:criminal_brushes/features/checkout/application/checkout_controller.dart';
import 'package:criminal_brushes/features/home/presentation/home_screen.dart';
import 'package:criminal_brushes/features/shared/presentation/placeholder_screen.dart';
import 'package:criminal_brushes/features/ui_kit/presentation/ui_kit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          builder: (context, state) =>
              ProductDetailsGuard(slug: state.pathParameters['slug'] ?? ''),
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
          builder: (context, state) => const CheckoutGuard(),
        ),
        GoRoute(
          path: '/order/confirmation',
          builder: (context, state) => const ConfirmationGuard(),
        ),
        GoRoute(
          path: '/ui-kit',
          builder: (context, state) => const UiKitScreen(),
        ),
      ],
    ),
  ],
);

class ProductDetailsGuard extends ConsumerWidget {
  const ProductDetailsGuard({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productBySlugProvider(slug));

    return product.when(
      data: (product) {
        if (product == null) {
          return const PlaceholderScreen(
            title: 'Product not found',
            description:
                'This mock product does not exist in the local catalog.',
            primaryPath: '/catalog',
            primaryLabel: 'Back to catalog',
          );
        }

        return PlaceholderScreen(
          title: product.name,
          description:
              'Product details shell for ${product.slug}. Full product UI starts in Milestone 2.',
          primaryPath: '/catalog',
          primaryLabel: 'Back to catalog',
        );
      },
      loading: () => const Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => PlaceholderScreen(
        title: 'Product error',
        description: 'Mock product lookup failed: $error',
        primaryPath: '/',
        primaryLabel: 'Back home',
      ),
    );
  }
}

class CheckoutGuard extends ConsumerWidget {
  const CheckoutGuard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(cartControllerProvider).isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go('/cart');
        }
      });

      return const PlaceholderScreen(
        title: 'Redirecting to cart',
        description: 'Checkout needs at least one mock cart item.',
      );
    }

    return const PlaceholderScreen(
      title: 'Checkout',
      description: 'Mock checkout form starts after cart UI.',
    );
  }
}

class ConfirmationGuard extends ConsumerWidget {
  const ConfirmationGuard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confirmation = ref.watch(mockOrderConfirmationProvider);

    if (confirmation == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go('/');
        }
      });

      return const PlaceholderScreen(
        title: 'Redirecting home',
        description:
            'Confirmation needs a mock order from the current session.',
      );
    }

    return PlaceholderScreen(
      title: 'Confirmation',
      description:
          'Demo order ${confirmation.orderNumber} was created locally.',
      primaryPath: '/',
      primaryLabel: 'Back home',
    );
  }
}
