import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/breakpoints.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';
import 'product_card.dart';

class SliverProductsGrid extends ConsumerWidget {
  const SliverProductsGrid({super.key, this.onPressed});
  final void Function(BuildContext, ProductID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListValue = ref.watch(productsListStreamProvider);
    return AsyncValueSliverWidget<List<Product>>(
      value: productsListValue,
      data: (products) => SliverProductsAlignedGrid(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            tag: 'product',
            onPressed: () => onPressed?.call(context, product.id),
          );
        },
      ),
    );
  }
}

class SliverProductsAlignedGrid extends StatelessWidget {
  const SliverProductsAlignedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;

  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'No products found'.hardcoded,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    }
    return SliverLayoutBuilder(builder: (context, constraints) {
      final width = constraints.crossAxisExtent;
      final maxWidth = min(width, Breakpoint.mobile);
      var result = maxWidth ~/ 180;
      final crossAxisCount = max(1, result);
      final padding = width > Breakpoint.desktop + Sizes.p32
          ? (width - Breakpoint.desktop) / 2
          : Sizes.p16;
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: Sizes.p16),
        sliver: SliverAlignedGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: Sizes.p24,
          crossAxisSpacing: Sizes.p24,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
        ),
      );
    });
  }
}
