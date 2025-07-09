import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caterfit/user/packageDetail.dart';

void main() {
  final testWidget = MaterialApp(
    home: PackageDetailScreen(),
  );

  // Mocking the PackageDetailScreen class
  testWidgets('Initial default week count is correct',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    final subscribeButton = find.byKey(const Key('subscribeButton'));
    await tester.dragUntilVisible(
      subscribeButton,
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    await tester.tap(subscribeButton);
    await tester.pumpAndSettle();
    expect(find.text('1 Week(s)'), findsOneWidget);
    expect(PackageDetailScreen.subscriptionWeeks, 1);
  });

  testWidgets('Decrement button is disabled when weeks <= 1',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    final decrementButton = find.byKey(const Key('minusButton'));
    final IconButton iconButton = tester.widget<IconButton>(decrementButton);
    expect(iconButton.onPressed, isNull);
  });

  testWidgets('Increment button increases week count',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    final incrementButton = find.byKey(const Key('plusButton'));
    await tester.dragUntilVisible(
      incrementButton,
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    await tester.tap(incrementButton);
    await tester.pumpAndSettle();
    expect(PackageDetailScreen.subscriptionWeeks, 2);
    expect(find.text('2 Week(s)'), findsOneWidget);
  });

  testWidgets('Decrement button decreases week count when weeks > 1',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    final decrementButton = find.byKey(const Key('minusButton'));
    await tester.dragUntilVisible(
      decrementButton,
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    await tester.tap(decrementButton);
    await tester.pumpAndSettle();

    expect(find.text('1 Week(s)'), findsOneWidget);
    expect(PackageDetailScreen.subscriptionWeeks, 1);
  });

  testWidgets('Increment button is disabled when weeks >= stock',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    final incrementButton = find.byKey(const Key('plusButton'));
    await tester.dragUntilVisible(
      incrementButton,
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    while (PackageDetailScreen.subscriptionWeeks < PackageDetailScreen.stock) {
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
    }
    await tester.tap(incrementButton);
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<AnimatedOpacity>(find.byKey(const Key('stockAlert')))
            .opacity,
        1.0);
  });

  testWidgets('UI updates correctly when reaching stock limit',
      (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    final incrementButton = find.byKey(const Key('plusButton'));
    await tester.dragUntilVisible(
      incrementButton,
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    while (PackageDetailScreen.subscriptionWeeks < PackageDetailScreen.stock) {
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
    }
    await tester.tap(incrementButton);
    await tester.pumpAndSettle();
    expect(find.text('${PackageDetailScreen.stock} Week(s)'), findsOneWidget);
    expect(PackageDetailScreen.subscriptionWeeks, PackageDetailScreen.stock);
  });
}
