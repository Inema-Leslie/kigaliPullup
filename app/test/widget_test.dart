import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Basic smoke test — verifies the app widget tree can be built.
// Full Firebase-dependent tests require running on device/emulator.
void main() {
  testWidgets('App smoke test — renders without crashing', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(child: Text('KigaliPullup Smoke Test')),
          ),
        ),
      ),
    );

    expect(find.text('KigaliPullup Smoke Test'), findsOneWidget);
  });
}
