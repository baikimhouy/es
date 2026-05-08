// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_product_detail_app/core/theme/app_theme.dart';
import 'package:flutter_product_detail_app/data/demo/demo_product_detail.dart';
import 'package:flutter_product_detail_app/features/product_detail/presentation/pages/product_detail_page.dart';

void main() {
  testWidgets('renders product detail content', (WidgetTester tester) async {
    // Pump ProductDetailPage directly with demo data.
    // MyApp now starts on HomeScreen so pumping the full app would
    // no longer show product detail content on the first frame.
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: ProductDetailPage(product: DemoProductDetail.product),
      ),
    );

    // Let all animations and async frames settle
    await tester.pumpAndSettle();

    expect(find.text('Ready to Wear Downy Cheek'), findsOneWidget);
    expect(find.text('Select Color'), findsOneWidget);
    expect(find.text('You may also like'), findsOneWidget);
    expect(find.text('Review(3)'), findsWidgets);
  });
}
