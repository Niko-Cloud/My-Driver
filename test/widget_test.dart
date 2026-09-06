import 'package:flutter_test/flutter_test.dart';

import 'package:my_driver/app/app.dart';

void main() {
  testWidgets('Login screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MyDriverApp());

    expect(find.text('Laju'), findsOneWidget);
    expect(find.text('Masuk'), findsWidgets);
  });
}
