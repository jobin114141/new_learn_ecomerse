import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your actual app models and providers
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/wishlist/data/models/wishlist_models.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/get_wishlist_products_use_case.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/toggle_wishlist_use_case.dart';
import 'package:my_ecomerse/features/wishlist/presentation/providers/wishlist_provider.dart';

// 1. Create Mocks for the UseCases using Mocktail!
class MockGetWishlistUseCase extends Mock implements GetWishlistProductsUseCase {}
class MockToggleWishlistUseCase extends Mock implements ToggleWishlistUseCase {}

void main() {
  late MockGetWishlistUseCase mockGetUseCase;
  late MockToggleWishlistUseCase mockToggleUseCase;
  late ProviderContainer container;

  setUp(() {
    // 2. Mock SharedPreferences for testing so it doesn't throw errors
    SharedPreferences.setMockInitialValues({});
    
    mockGetUseCase = MockGetWishlistUseCase();
    mockToggleUseCase = MockToggleWishlistUseCase();

    // 3. Create a Riverpod Container that injects our Mocks instead of real API calls!
    container = ProviderContainer(
      overrides: [
        getWishlistProductsUseCaseProvider.overrideWithValue(mockGetUseCase),
        toggleWishlistUseCaseProvider.overrideWithValue(mockToggleUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('WishlistNotifier Tests -', () {
    
    test('fetchWishlist correctly updates state with items when successful', () async {
      // ARRANGE: Create fake product & tell mock what to return
      final fakeProduct = Product(id: 1, name: 'Fake Shoe', price: 100.0, image: [''], status: 1);
      final fakeModel = WishListModel(products: [fakeProduct]);
      
      when(() => mockGetUseCase.execute())
          .thenAnswer((_) async => Right(fakeModel)); // Return success (Right)

      // Get the Notifier from the container
      final notifier = container.read(wishlistNotifierProvider.notifier);

      // ACT: Execute the method
      await notifier.fetchWishlist();

      // ASSERT: Check that state was updated properly!
      final state = container.read(wishlistNotifierProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, null);
      expect(state.wishlistItems.length, 1);
      expect(state.wishlistItems.first.name, 'Fake Shoe');

      // Wait a tiny bit for the initial build() microtasks to also finish 
      // so they don't try to access the disposed container in tearDown.
      await Future.delayed(const Duration(milliseconds: 50));
    });

  });
}
