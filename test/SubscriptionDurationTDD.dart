import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caterfit/user/packageDetail.dart';

void main() {
  final testWidget = MaterialApp(
    home: PackageDetailScreen(),
  );

  // Mocking the PackageDetailScreen class
  test('Initial default week count is correct', () {
    expect(PackageDetailScreen.subscriptionWeeks, 1);
  });

  testWidgets('Decrement button is disabled when weeks <= 1', (WidgetTester tester) async {
    
    await tester.pumpWidget(testWidget);
    final subscribeButton = find.byKey(const Key('subscribeButton'));
    await tester.tap(subscribeButton);
    final decrementButton = find.byKey(const Key('minusButton'));
    
    // Verify the decrement button is disabled
    expect(decrementButton, findsOneWidget);
    final IconButton iconButton = tester.widget<IconButton>(decrementButton);
    expect(iconButton.onPressed, isNull);
  });

  // testWidgets('Increment button increases week count', (WidgetTester tester) async {
  //   await tester.pumpWidget(testWidget);
    
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
    
  //   expect(find.text('2 Week(s)'), findsOneWidget);
  // });

  // testWidgets('Decrement button decreases week count when weeks > 1', (WidgetTester tester) async {
  //   // Start with 2 weeks
  //   subscriptionWeeks = 2;
  //   await tester.pumpWidget(testWidget);
    
  //   await tester.tap(find.byIcon(Icons.remove));
  //   await tester.pump();
    
  //   expect(find.text('1 Week(s)'), findsOneWidget);
  // });

  // testWidgets('Increment button is disabled when weeks >= stock', (WidgetTester tester) async {
  //   subscriptionWeeks = 10;
  //   stock = 10;
  //   await tester.pumpWidget(testWidget);
    
  //   final incrementButton = tester.widget<IconButton>(find.byIcon(Icons.add));
  //   expect(incrementButton.onPressed, isNotNull);
    
  //   // Verify it calls showStockAlert when pressed at max
  //   bool alertShown = false;
  //   showStockAlert = () => alertShown = true;
  //   await tester.pumpWidget(testWidget);
    
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
    
  //   expect(alertShown, isTrue);
  // });

  // testWidgets('Confirm button calls confirmSubscription', (WidgetTester tester) async {
  //   bool confirmed = false;
  //   confirmSubscription = () => confirmed = true;
  //   await tester.pumpWidget(testWidget);
    
  //   await tester.tap(find.byIcon(Icons.check));
  //   await tester.pump();
    
  //   expect(confirmed, isTrue);
  // });

  // testWidgets('UI updates correctly when reaching stock limit', (WidgetTester tester) async {
  //   stock = 3;
  //   subscriptionWeeks = 2;
  //   await tester.pumpWidget(testWidget);
    
  //   // First increment (2 -> 3)
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //   expect(find.text('3 Week(s)'), findsOneWidget);
  // });
}