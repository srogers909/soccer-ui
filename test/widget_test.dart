// This is a basic Flutter widget test for the Soccer Manager UI.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soccer_manager_ui/main.dart';

void main() {
  testWidgets('Soccer Manager app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SoccerManagerApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app loads successfully
    // The app should have some basic UI elements
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App should build without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SoccerManagerApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // The test passes if we get here without throwing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
