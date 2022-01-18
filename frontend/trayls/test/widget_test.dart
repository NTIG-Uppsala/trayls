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
    expect(find.text('Nytt uppdrag'), findsOneWidget);
  });

  testWidgets('Button for task exists', (WidgetTester tester) async {
    //Test suite for the button
    await tester.pumpWidget(const Trayls());
    //Check if the button is displayed
    expect(find.byType(TextButton), findsOneWidget);
  });

  //Test button for page navigation
  testWidgets('Button for task navigation', (WidgetTester tester) async {
    //Test suite for the button
    await tester.pumpWidget(const Trayls());
    //Check if the button is displayed
    expect(find.byType(TextButton), findsOneWidget);
    //Check if the button navigates to the task page
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    expect(find.text('Uppdraget'), findsOneWidget);
  });
}
