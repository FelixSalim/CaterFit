import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:caterfit/user/packageDetail.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Subscription Duration Tests', () {
    testWidgets('User selects a subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();

      // When: the user clicks the "Subscribe Now" button
      final subscribeButton = find.byKey(const Key('subscribeButton'));
      await tester.dragUntilVisible(
        subscribeButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(subscribeButton);
      await tester.pumpAndSettle();

      // Then: the user should see "1 week" as my selected subscription duration
      expect(find.text('1 Week(s)'), findsOneWidget);
    });

    testWidgets('Decrement button is disabled when week count is 1',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();

      // And: the subscription duration is 1 week
      PackageDetailScreen.subscriptionWeeks = 1;
      await tester.pumpAndSettle();

      // When: the user clicks the decrement button
      final decrementButton = find.byKey(const Key('minusButton'));
      await tester.dragUntilVisible(
        decrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Then: the decrement button does not change the subscription duration
      expect(PackageDetailScreen.subscriptionWeeks, equals(1));

      // And: the subscription duration remains 1 week
      expect(find.text('1 Week(s)'), findsOneWidget);
    });

    testWidgets('The user increase the subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();

      // And: the current week count is less than the stock
      PackageDetailScreen.subscriptionWeeks = PackageDetailScreen.stock - 1;
      await tester.pumpAndSettle();

      // When: the user clicks the increment button
      final incrementButton = find.byKey(const Key('plusButton'));
      await tester.dragUntilVisible(
        incrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Then: the subscription duration should increase by 1 week
      expect(PackageDetailScreen.subscriptionWeeks,
          greaterThan(PackageDetailScreen.stock - 1));

      // And: the user should see the updated subscription duration
      final expectedText = '${PackageDetailScreen.subscriptionWeeks} Week(s)';
      expect(find.text(expectedText), findsOneWidget);
    });

    testWidgets('The user decrease the subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();

      // And: the current week count is more than 1
      PackageDetailScreen.subscriptionWeeks = 2;
      await tester.pumpAndSettle();

      // When: the user taps the decrement button
      final decrementButton = find.byKey(const Key('minusButton'));
      await tester.dragUntilVisible(
        decrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Then: the subscription week count decreases by 1
      expect(PackageDetailScreen.subscriptionWeeks, equals(1));

      // And: the screen shows the updated week count
      expect(find.text('1 Week(s)'), findsOneWidget);
    });

    testWidgets(
        'The user increase the subscription duration but the stock is not available',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();

      // And: the current week count is equal to the stock
      PackageDetailScreen.subscriptionWeeks = PackageDetailScreen.stock;
      await tester.pumpAndSettle();

      // When: the user taps the increment button
      final incrementButton = find.byKey(const Key('plusButton'));
      await tester.dragUntilVisible(
        incrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Then: the user should see a message "Stock not available"
      final stockAlert = find.byKey(const Key('stockAlert'));
      final widget = tester.widget<AnimatedOpacity>(stockAlert);
      expect(widget.opacity, equals(1.0));

      // And: the subscription duration should not change
      expect(PackageDetailScreen.subscriptionWeeks,
          equals(PackageDetailScreen.stock));
    });
  });
}
