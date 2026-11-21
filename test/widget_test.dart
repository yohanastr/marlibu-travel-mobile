
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:marlibu_travel_mobile/screens/splash/splash_screen.dart';

void main() {
  testWidgets('Marlibu Travel splash screen test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
  });
}
