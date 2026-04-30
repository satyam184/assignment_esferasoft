import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment_esferasoft/main.dart';

void main() {
  testWidgets('login validates and opens trips list', (tester) async {
    await tester.pumpWidget(const TripsBookingsApp());

    expect(find.text('Trips & Bookings'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'invalid-email');
    await tester.enterText(find.byType(TextField).at(1), '123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(
      find.text('Password must be at least 6 characters'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'secret1');

    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('My Trips'), findsOneWidget);
    expect(find.text('Downtown Seattle to Sea-Tac'), findsOneWidget);
  });

  testWidgets('trip status updates from details screen and returns home', (
    tester,
  ) async {
    await tester.pumpWidget(const TripsBookingsApp());

    await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'secret1');
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField),
      'Downtown Seattle to Sea-Tac',
    );
    await tester.pumpAndSettle();

    final tripTile = find.widgetWithText(
      ListTile,
      'Downtown Seattle to Sea-Tac',
    );
    expect(tripTile, findsOneWidget);

    await tester.tap(tripTile);
    await tester.pumpAndSettle();

    expect(find.text('Trip Details'), findsOneWidget);
    expect(find.text('Trip ID'), findsOneWidget);
    expect(find.text('Change Status'), findsOneWidget);

    final dropdownFinder = find.byType(DropdownButtonFormField<String>);
    await tester.ensureVisible(dropdownFinder);
    await tester.tap(dropdownFinder, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Completed').last);
    await tester.pumpAndSettle();

    expect(find.text('My Trips'), findsOneWidget);
    expect(find.text('COMPLETED'), findsOneWidget);
  });
}
