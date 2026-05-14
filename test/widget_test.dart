import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyPortfolioApp());
    expect(find.byType(MyPortfolioApp), findsOneWidget);
  });
}
