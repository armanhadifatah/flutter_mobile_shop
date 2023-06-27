import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/src/features/cart/domain/mutable_cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exceptions/error_logger.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/domain/app_user.dart';
import '../../products/data/products_repository.dart';
import '../data/local/local_cart_repository.dart';
import '../data/remote/remote_cart_repository.dart';
import '../domain/cart.dart';
import '../domain/item.dart';

part 'cart_sync_service.g.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        _moveItemsToRemoteCart(user.uid);
      }
    });
  }

  /// moves all items from the local to the remote cart taking into account the
  /// available quantities
  Future<void> _moveItemsToRemoteCart(UserID uid) async {
    try {
      // Get the local cart data
      final localCartRepository = ref.read(localCartRepositoryProvider);
      final localCart = await localCartRepository.fetchCart();
      if (localCart.items.isNotEmpty) {
        // Get the remote cart data
        final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
        final remoteCart = await remoteCartRepository.fetchCart(uid);
        final localItemsToAdd =
            await _getLocalItemsToAdd(localCart, remoteCart);
        // Add all the local items to the remote cart
        final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
        // Write the updated remote cart data to the repository
        await remoteCartRepository.setCart(uid, updatedRemoteCart);
        // Remove all items from the local cart
        await localCartRepository.setCart(const Cart());
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }

  Future<List<Item>> _getLocalItemsToAdd(
      Cart localCart, Cart remoteCart) async {
    // Get the list of products (needed to read the available quantities)
    final productsRepository = ref.read(productsRepositoryProvider);
    final products = await productsRepository.fetchProductsList();
    // Figure out which items need to be added
    final localItemsToAdd = <Item>[];
    for (final localItem in localCart.items.entries) {
      final productId = localItem.key;
      final localQuantity = localItem.value;
      // get the quantity for the corresponding item in the remote cart
      final remoteQuantity = remoteCart.items[productId] ?? 0;
      final product = products.firstWhere((product) => product.id == productId);
      // Cap the quantity of each item to the available quantity
    }
    return localItemsToAdd;
  }
}

// * Using keepAlive since this should live for the entire app lifecycle
@Riverpod(keepAlive: true)
CartSyncService cartSyncService(CartSyncServiceRef ref) {
  return CartSyncService(ref);
}
