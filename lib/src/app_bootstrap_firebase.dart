import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/src/features/products/data/fake_products_repository.dart';
import 'package:mobile_shop/src/features/products/data/products_repository.dart';

import 'exceptions/async_error_logger.dart';

Future<ProviderContainer> createFirebaseProviderContainer(
    {bool addDelay = true}) async {
  final fakeProductsRepository = FakeProductsRepository(addDelay: addDelay);

  return ProviderContainer(
    overrides: [
      // repositories
      productsRepositoryProvider.overrideWithValue(fakeProductsRepository),
    ],
    observers: [AsyncErrorLogger()],
  );
}
