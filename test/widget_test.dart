import 'package:flutter_test/flutter_test.dart';

import 'package:caiacosmetics_6/app.dart';

void main() {
  testWidgets('App renders splash then shell', (WidgetTester tester) async {
    await tester.pumpWidget(const CaiaApp());
    expect(find.text('CAIA Cosmetics'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pumpAndSettle();

    expect(find.text('Hjem'), findsOneWidget);
    expect(find.text('Hudscan'), findsOneWidget);
  });
}
