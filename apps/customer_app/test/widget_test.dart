import 'package:criminal_brushes/app/app.dart';
import 'package:criminal_brushes/app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() {
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.resetPhysicalSize();
    view.resetDevicePixelRatio();
  });

  testWidgets('home screen renders the MVP hero', (tester) async {
    appRouter.go('/');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('CRIMINAL BRUSHES'), findsWidgets);
    expect(find.text('BRUSH LIKE A REBEL'), findsOneWidget);
    expect(find.text('Browse catalog'), findsOneWidget);
  });

  testWidgets('ui kit route renders foundation samples', (tester) async {
    appRouter.go('/');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open UI kit'));
    await tester.pumpAndSettle();

    expect(find.text('UI Kit'), findsWidgets);
    expect(find.text('Palette'), findsOneWidget);
    expect(find.text('Product card'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Quantity and cart row'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Quantity and cart row'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Checkout stepper'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Checkout stepper'), findsOneWidget);
  });

  testWidgets('ui kit opens on mobile width', (tester) async {
    await _setSurfaceSize(tester, const Size(390, 900));

    appRouter.go('/ui-kit');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('UI Kit'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ui kit opens on desktop width', (tester) async {
    await _setSurfaceSize(tester, const Size(1280, 900));

    appRouter.go('/ui-kit');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('UI Kit'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('unknown product slug shows not found state', (tester) async {
    appRouter.go('/product/not-a-product');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('Product not found'), findsOneWidget);
    expect(find.text('Back to catalog'), findsOneWidget);
  });

  testWidgets('checkout without cart redirects to cart placeholder', (
    tester,
  ) async {
    appRouter.go('/checkout');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Browse catalog'), findsWidgets);
  });

  testWidgets('confirmation without mock order redirects home', (tester) async {
    appRouter.go('/order/confirmation');
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('BRUSH LIKE A REBEL'), findsOneWidget);
  });
}

Future<void> _setSurfaceSize(WidgetTester tester, Size size) async {
  final view = tester.view;
  view.devicePixelRatio = 1;
  view.physicalSize = size;
  addTearDown(() {
    view.resetPhysicalSize();
    view.resetDevicePixelRatio();
  });
}
