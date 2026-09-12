import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_ecomerse/common/widgets/custom_button.dart';

void main() {
  group('CustomButtonWidget Tests', () {
    testWidgets('renders buttonText correctly', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Click Me';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget(
              buttonText: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (WidgetTester tester) async {
      // Arrange
      bool wasTapped = false;
      const buttonText = 'Tap Me';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget(
              buttonText: buttonText,
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(CustomButtonWidget));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTapped, true);
    });

    testWidgets('shows loading indicator and text when isLoading is true', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget(
              buttonText: 'Submit',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      // Assert
      // 1. Should show CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // 2. Should show 'loading' text as defined in the widget
      expect(find.text('loading'), findsOneWidget);
      // 3. Should NOT show the original buttonText
      expect(find.text('Submit'), findsNothing);
    });

    testWidgets('does not trigger onPressed when isLoading is true', (WidgetTester tester) async {
      // Arrange
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget(
              buttonText: 'Submit',
              isLoading: true,
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(CustomButtonWidget));
      await tester.pump();

      // Assert
      expect(wasTapped, false);
    });

    testWidgets('renders an icon if provided', (WidgetTester tester) async {
      // Arrange
      const icon = Icons.shopping_cart;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButtonWidget(
              buttonText: 'Add to Cart',
              icon: icon,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(icon), findsOneWidget);
    });
  });
}
