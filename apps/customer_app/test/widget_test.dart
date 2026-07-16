import 'package:criminal_brushes/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home screen renders the MVP hero', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CriminalBrushesApp()));
    await tester.pumpAndSettle();

    expect(find.text('CRIMINAL BRUSHES'), findsOneWidget);
    expect(find.text('BRUSH LIKE\nA REBEL'), findsOneWidget);
    expect(find.text('СМОТРЕТЬ КАТАЛОГ'), findsOneWidget);
  });
}
