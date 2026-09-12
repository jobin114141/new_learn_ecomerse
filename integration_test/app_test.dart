import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_ecomerse/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app loads and navigates to wishlist', (tester) async {
      // Launch the app
      app.main();
      
      // Wait for the app to finish its initial build and animations
      await tester.pumpAndSettle();

      // Verify that the app root widget is present
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Look for the favorite (wishlist) icon in the app bar
      final wishlistIcon = find.byIcon(Icons.favorite_border_rounded);
      expect(wishlistIcon, findsOneWidget);

      // Tap the wishlist icon
      await tester.tap(wishlistIcon);

      // Wait for the navigation animation to complete
      await tester.pumpAndSettle();

      // Verify we are on the Wishlist screen by looking for its title
      expect(find.text('My Wishlist'), findsOneWidget);
    });
  });
}
