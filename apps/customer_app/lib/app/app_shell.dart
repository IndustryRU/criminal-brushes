import 'package:criminal_brushes/core/theme/app_breakpoints.dart';
import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:criminal_brushes/core/theme/app_spacing.dart';
import 'package:criminal_brushes/features/cart/application/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => context.go('/'),
          child: const Text(
            'CRIMINAL BRUSHES',
            style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0),
          ),
        ),
        actions: [
          if (MediaQuery.sizeOf(context).width >= AppBreakpoints.desktop) ...[
            TextButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('Catalog'),
            ),
            TextButton(onPressed: () {}, child: const Text('About')),
            TextButton(onPressed: () {}, child: const Text('Delivery')),
            TextButton(onPressed: () {}, child: const Text('FAQ')),
            TextButton(
              onPressed: () => context.go('/ui-kit'),
              child: const Text('UI Kit'),
            ),
          ],
          _CartButton(count: ref.watch(cartItemCountProvider)),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      drawer: MediaQuery.sizeOf(context).width < AppBreakpoints.desktop
          ? const _AppDrawer()
          : null,
      body: child,
      bottomNavigationBar: const _AppFooter(),
    );
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Cart',
      onPressed: () => context.go('/cart'),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text(count.toString()),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Catalog'),
              onTap: () => context.go('/catalog'),
            ),
            ListTile(title: const Text('About'), onTap: () {}),
            ListTile(title: const Text('Delivery'), onTap: () {}),
            ListTile(title: const Text('FAQ'), onTap: () {}),
            ListTile(
              title: const Text('UI Kit'),
              onTap: () => context.go('/ui-kit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.black,
        border: Border(top: BorderSide(color: AppColors.lineGray)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: AppSpacing.sm,
          children: const [
            Text(
              'CRIMINAL BRUSHES',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Placeholder links: legal, contacts, delivery.',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
