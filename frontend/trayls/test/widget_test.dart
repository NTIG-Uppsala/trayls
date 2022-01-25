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
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  //Test button for page navigation
  testWidgets('Button for task navigation', (WidgetTester tester) async {
    //Test suite for the button
    await tester.pumpWidget(const Trayls());
    //Check if the button is displayed
    expect(find.text('Nytt uppdrag'), findsOneWidget);
    //Check if the button navigates to the task page
    await tester.tap(find.text('Nytt uppdrag'));
    await tester.pumpAndSettle();
    expect(find.text('Uppdraget'), findsOneWidget);
});

//Test button for complete task
  testWidgets('Button to complete task', (WidgetTester tester) async {
    //Test suite for the button
    await tester.pumpWidget(const Trayls());
    //navigate to the task page
    await tester.tap(find.text('Nytt uppdrag'));
    await tester.pumpAndSettle();
    //Check if completed button exists
    expect(find.text('Klar'), findsOneWidget);
    await tester.tap(find.text('Klar'));
    await tester.pumpAndSettle();
    //Checks if button takes back to main page
    expect(find.text('Trayls'), findsOneWidget);
});

//Test button for cancel task
  testWidgets('Button to cancel task', (WidgetTester tester) async {
    //Test suite for the button
    await tester.pumpWidget(const Trayls());
    //navigate to the task page
    await tester.tap(find.text('Nytt uppdrag'));
    await tester.pumpAndSettle();
    //Check if cancel button exists
    expect(find.text('Skippa'), findsOneWidget);
    await tester.tap(find.text('Avbryt'));
    await tester.pumpAndSettle();
    //Checks if button takes back to main page
    expect(find.text('Uppdraget'), findsOneWidget);
});
}