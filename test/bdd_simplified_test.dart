import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:caterfit/user/packageDetail.dart';

// The simplest approach for BDD-style testing using standard Flutter widget tests
// organized by Given-When-Then pattern

void main() {
  group('Subscription Duration Tests', () {
    // Helper methods that represent the steps in your Gherkin feature file

    // GIVEN STEPS
    Future<void> givenUserIsOnPackageDetailScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: PackageDetailScreen()));
      await tester.pumpAndSettle();
    }

    Future<void> givenSubscriptionDurationIs(
        WidgetTester tester, int weeks) async {
      PackageDetailScreen.subscriptionWeeks = weeks;
      await tester.pumpAndSettle();
    }

    Future<void> givenWeekCountLessThanStock(WidgetTester tester) async {
      PackageDetailScreen.subscriptionWeeks = PackageDetailScreen.stock - 1;
      await tester.pumpAndSettle();
    }

    Future<void> givenWeekCountMoreThanOne(WidgetTester tester) async {
      PackageDetailScreen.subscriptionWeeks = 2;
      await tester.pumpAndSettle();
    }

    Future<void> givenWeekCountEqualToStock(WidgetTester tester) async {
      PackageDetailScreen.subscriptionWeeks = PackageDetailScreen.stock;
      await tester.pumpAndSettle();
    }

    // WHEN STEPS
    Future<void> whenUserClicksSubscribeButton(WidgetTester tester) async {
      final subscribeButton = find.byKey(const Key('subscribeButton'));
      await tester.dragUntilVisible(
        subscribeButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(subscribeButton);
      await tester.pumpAndSettle();
    }

    Future<void> whenUserClicksDecrementButton(WidgetTester tester) async {
      final decrementButton = find.byKey(const Key('minusButton'));
      await tester.dragUntilVisible(
        decrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
    }

    Future<void> whenUserClicksIncrementButton(WidgetTester tester) async {
      final incrementButton = find.byKey(const Key('plusButton'));
      await tester.dragUntilVisible(
        incrementButton,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
    }

    // THEN STEPS
    void thenUserSeesSelectedDuration(WidgetTester tester, String duration) {
      expect(find.text(duration), findsOneWidget);
    }

    void thenDecrementButtonNoChange(WidgetTester tester) {
      expect(PackageDetailScreen.subscriptionWeeks, equals(1));
    }

    void thenDurationRemainsOneWeek(WidgetTester tester) {
      expect(PackageDetailScreen.subscriptionWeeks, equals(1));
      expect(find.text('1 Week(s)'), findsOneWidget);
    }

    void thenDurationIncreases(WidgetTester tester, int previousCount) {
      expect(PackageDetailScreen.subscriptionWeeks, greaterThan(previousCount));
    }

    void thenUserSeesUpdatedDuration(WidgetTester tester) {
      final expectedText = '${PackageDetailScreen.subscriptionWeeks} Week(s)';
      expect(find.text(expectedText), findsOneWidget);
    }

    void thenWeekCountDecreases(WidgetTester tester, int previousCount) {
      expect(PackageDetailScreen.subscriptionWeeks, lessThan(previousCount));
    }

    void thenScreenShowsUpdatedCount(WidgetTester tester) {
      final expectedText = '${PackageDetailScreen.subscriptionWeeks} Week(s)';
      expect(find.text(expectedText), findsOneWidget);
    }

    void thenUserSeesStockNotAvailableMessage(WidgetTester tester) {
      final stockAlert = find.byKey(const Key('stockAlert'));
      final widget = tester.widget<AnimatedOpacity>(stockAlert);
      expect(widget.opacity, equals(1.0));
    }

    void thenDurationDoesNotChange(WidgetTester tester, int expectedWeeks) {
      expect(PackageDetailScreen.subscriptionWeeks, equals(expectedWeeks));
    }

    // SCENARIOS
    testWidgets('Scenario: User selects a subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await givenUserIsOnPackageDetailScreen(tester);

      // When: the user clicks the "Subscribe Now" button
      await whenUserClicksSubscribeButton(tester);

      // Then: the user should see "1 week" as my selected subscription duration
      thenUserSeesSelectedDuration(tester, '1 Week(s)');
    });

    testWidgets('Scenario: Decrement button is disabled when week count is 1',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await givenUserIsOnPackageDetailScreen(tester);

      // And: the subscription duration is 1 week
      await givenSubscriptionDurationIs(tester, 1);

      // When: the user clicks the decrement button
      await whenUserClicksDecrementButton(tester);

      // Then: the decrement button does not change the subscription duration
      thenDecrementButtonNoChange(tester);

      // And: the subscription duration remains 1 week
      thenDurationRemainsOneWeek(tester);
    });

    testWidgets('Scenario: The user increase the subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await givenUserIsOnPackageDetailScreen(tester);

      // And: the current week count is less than the stock
      await givenWeekCountLessThanStock(tester);
      int previousCount = PackageDetailScreen.subscriptionWeeks;

      // When: the user clicks the increment button
      await whenUserClicksIncrementButton(tester);

      // Then: the subscription duration should increase by 1 week
      thenDurationIncreases(tester, previousCount);

      // And: the user should see the updated subscription duration
      thenUserSeesUpdatedDuration(tester);
    });

    testWidgets('Scenario: The user decrease the subscription duration',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await givenUserIsOnPackageDetailScreen(tester);

      // And: the current week count is more than 1
      await givenWeekCountMoreThanOne(tester);
      int previousCount = PackageDetailScreen.subscriptionWeeks;

      // When: the user taps the decrement button
      await whenUserClicksDecrementButton(tester);

      // Then: the subscription week count decreases by 1
      thenWeekCountDecreases(tester, previousCount);

      // And: the screen shows the updated week count
      thenScreenShowsUpdatedCount(tester);
    });

    testWidgets(
        'Scenario: The user increase the subscription duration but the stock is not available',
        (WidgetTester tester) async {
      // Given: the user is on the Package Detail Screen
      await givenUserIsOnPackageDetailScreen(tester);

      // And: the current week count is equal to the stock
      await givenWeekCountEqualToStock(tester);
      int previousCount = PackageDetailScreen.subscriptionWeeks;

      // When: the user taps the increment button
      await whenUserClicksIncrementButton(tester);

      // Then: the user should see a message "Stock not available"
      thenUserSeesStockNotAvailableMessage(tester);

      // And: the subscription duration should not change
      thenDurationDoesNotChange(tester, previousCount);
    });
  });
}
