// This is a basic Flutter widget test for the Tactics FC UI.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tactics_fc_ui/main.dart';

void main() {
  testWidgets('Tactics FC app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TacticsFCApp());

    // Wait for initial render (avoiding infinite animations)
    await tester.pump();
    await tester.pump(Duration(milliseconds: 100));

    // Verify that the app loads successfully
    // The app should have some basic UI elements
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App should build without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TacticsFCApp());

    // Wait for initial render (avoiding infinite animations)
    await tester.pump();
    await tester.pump(Duration(milliseconds: 100));

    // The test passes if we get here without throwing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
