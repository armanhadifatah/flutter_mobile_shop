import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';
import 'package:mobile_shop/src/utils/async_value_ui.dart';

import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/app_sizes.dart';
import '../../../products/domain/product.dart';
import '../item_quantity_selector.dart';
import 'add_to_cart_controller.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      addToCartControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(addToCartControllerProvider);
    final quantity = ref.watch(itemQuantityControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'.hardcoded),
            ItemQuantitySelector(
              quantity: quantity,
              // let the user choose up to the available quantity or
              // 10 items at most
              onChanged: state.isLoading
                  ? null
                  : (quantity) => ref
                      .read(itemQuantityControllerProvider.notifier)
                      .updateQuantity(quantity),
            ),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
            isLoading: state.isLoading,
            onPressed: () => ref
                .read(addToCartControllerProvider.notifier)
                .addItem(product.id),
            text: 'Add to Cart'.hardcoded),
        // if (product.availableQuantity > 0 && availableQuantity == 0) ...[
        //   gapH8,
        //   Text(
        //     'Already added to cart'.hardcoded,
        //     style: Theme.of(context).textTheme.bodySmall,
        //     textAlign: TextAlign.center,
        //   ),
        // ]
      ],
    );
  }
}
