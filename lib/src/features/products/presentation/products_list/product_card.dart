import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/custom_image.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/currency_formatter.dart';
import '../../domain/product.dart';

/// Used to show a single product inside a card.
class ProductCard extends ConsumerWidget {
  const ProductCard(
      {super.key, required this.product, this.onPressed, required this.tag});
  final Product product;
  final VoidCallback? onPressed;
  final String tag;

  // * Keys for testing using find.byKey()
  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p32),
      ),
      child: InkWell(
        key: productCardKey,
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.p32),
                color: Colors.white,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.p32),
                  child: Hero(
                    tag: '$tag-${product.id}',
                    child: CustomImage(
                      imageUrl: product.imageUrl,
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: Column(
                  children: [
                    Text(product.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    gapH4,
                    Text(priceFormatted,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )),
            gapH4,
          ],
        ),
      ),
    );
  }
}
