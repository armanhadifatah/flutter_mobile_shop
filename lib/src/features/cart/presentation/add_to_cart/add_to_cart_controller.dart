import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../products/domain/product.dart';
import '../../application/cart_service.dart';
import '../../domain/item.dart';

part 'add_to_cart_controller.g.dart';

@riverpod
class AddToCartController extends _$AddToCartController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> addItem(ProductID productId) async {
    final cartService = ref.read(cartServiceProvider);
    final quantity = ref.read(itemQuantityControllerProvider);
    final item = Item(productId: productId, quantity: quantity);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(() => cartService.addItem(item));
    if (!state.hasError) {
      ref.read(itemQuantityControllerProvider.notifier).updateQuantity(1);
    }
  }
}

@riverpod
class ItemQuantityController extends _$ItemQuantityController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }
}
