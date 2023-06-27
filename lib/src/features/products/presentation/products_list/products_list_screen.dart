import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_shop/src/configs/app_icon.dart';
import 'package:mobile_shop/src/features/products/presentation/products_list/search_bar.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';

import '../../../../constants/app_font_size.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import 'sliver_products_grid.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  Widget _filterButton(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppIcon.filter),
      color: Colors.white,
      onPressed: () {},
    );
  }

  Widget _cartButton(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppIcon.cart),
      color: Colors.white,
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ProductsListScreen build');
    return Scaffold(
      appBar: AppBar(
        leading: _filterButton(context),
        actions: [
          _cartButton(context),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 120.0,
            toolbarHeight: 0,
            bottom: AppBar(
              title: SearchBarWidget(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
                child: Text(
                  'Find your Phone'.hardcoded,
                  style: const TextStyle(fontSize: AppFontSize.headLine1),
                ),
              ),
            ),
          ),
          SliverProductsGrid(
            key: const Key('sliver-products-grid'),
            onPressed: (BuildContext, id) {
              context
                  .pushNamed(AppRoute.product.name, pathParameters: {'id': id});
            },
          ),
        ],
      ),
    );
  }
}
