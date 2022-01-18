import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trayls/main.dart';

void main() {
  testWidgets('Start page test', (WidgetTester tester) async {
    //Test suite for the start page
    await tester.pumpWidget(const Trayls());
    //Check if header exists
    expect(find.text('Trayls'), findsOneWidget);
    // Very basic test to check if the contet of the start page is displayed
    expect(find.text('Ny task'), findsOneWidget);
  });

  testWidgets('Button for task exists', (WidgetTester testere) async {
    //Test suite for the button
    await testere.pumpWidget(const Trayls());
    //Check if the button is displayed
    expect(find.byType(TextButton), findsOneWidget);
  });
}
