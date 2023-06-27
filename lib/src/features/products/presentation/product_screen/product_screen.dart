import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop/src/common_widgets/custom_image.dart';
import 'package:mobile_shop/src/configs/app_icon.dart';
import 'package:mobile_shop/src/features/favorite/data/favorite_repository.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/empty_placeholder_widget.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/currency_formatter.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';
import '../../domain/product_type.dart';

final favorateUpdateProvider = StateProvider<int>((ref) => 0);

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key, required this.productId}) : super(key: key);
  final String productId;

  String? selectedProductTypeId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final productValue = ref.watch(productStreamProvider(productId));
          return AsyncValueWidget<Product?>(
            value: productValue,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(
                    message: 'Product not found'.hardcoded,
                  )
                : SafeArea(
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: size.height * 0.5,
                            child: Hero(
                              tag: 'product-${product.id}',
                              child: CustomImage(
                                imageUrl: product.imageUrl,
                              ),
                            ),
                          ),

                          // back button with white background

                          Positioned(
                            top: 5,
                            left: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(AppIcon.back,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .color!,
                                        BlendMode.srcIn)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          // add favorite button
                          Positioned(
                            top: 5,
                            right: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Consumer(builder: (BuildContext,
                                  WidgetRef ref, Widget? widget) {
                                var isFavorite = ref
                                    .watch(isFavoriteStreamProvider(product));
                                return isFavorite.when(
                                    data: (data) {
                                      return IconButton(
                                        icon: SvgPicture.asset(
                                          data
                                              ? AppIcon.favoriteFilled
                                              : AppIcon.favorite,
                                          colorFilter: ColorFilter.mode(
                                              data
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .color!,
                                              BlendMode.srcIn),
                                        ),
                                        onPressed: () {
                                          // create 10 character random number
                                          var random = Random().nextInt(10);

                                          print('data $random');

                                          data
                                              ? ref.read(
                                                  removeFromFavoriteFutureProvider(
                                                      product))
                                              : ref.read(
                                                  addToFavoriteFutureProvider(
                                                      product));
                                          ref
                                              .read(favoritesListProvider
                                                  .notifier)
                                              .fetchFavoriteList();
                                        },
                                      );
                                    },
                                    error: (error, stackTrace) => IconButton(
                                          icon: SvgPicture.asset(
                                            AppIcon.favorite,
                                            colorFilter: ColorFilter.mode(
                                                Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .color!,
                                                BlendMode.srcIn),
                                          ),
                                          onPressed: () {},
                                        ),
                                    loading: () => IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                            AppIcon.favorite,
                                            colorFilter: ColorFilter.mode(
                                                Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .color!,
                                                BlendMode.srcIn),
                                          ),
                                        ));
                              }),
                            ),
                          ),
                          // detail area
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: SizedBox(
                                  height: size.height * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      gapH8,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(product.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge),
                                          Text(
                                              ref
                                                  .watch(
                                                      currencyFormatterProvider)
                                                  .format(product.price),
                                              style: TextStyle(
                                                  fontSize:
                                                      AppFontSize.headline,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ],
                                      ),
                                      gapH20,
                                      _ratingBar(product.avgRating,
                                          product.numRatings, context),
                                      gapH20,
                                      ProductTypes(
                                          productTypes: product.productTypes,
                                          context: context,
                                          size: size),
                                      gapH16,
                                      Row(
                                        children: [
                                          Text(
                                            'Colors',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          )
                                        ],
                                      ),
                                      gapH4,
                                      ProdcutColos(
                                        colors: product.colors,
                                        context: context,
                                        size: size,
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 60,
                                        child: PrimaryButton(
                                          onPressed: () {},
                                          text: 'Get Started'.hardcoded,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _ratingBar(double avgRating, int noRating, BuildContext context) {
    return RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        itemSize: 30,
        direction: Axis.horizontal,
        unratedColor: Theme.of(context).primaryColor,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) {
          return SvgPicture.asset(
            AppIcon.star,
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor, BlendMode.srcIn),
            width: 20,
            height: 20,
          );
        },
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}

class ProductTypes extends StatefulWidget {
  const ProductTypes({
    super.key,
    required this.productTypes,
    required this.context,
    required this.size,
  });

  final List<ProductType> productTypes;
  final BuildContext context;
  final Size size;

  @override
  State<ProductTypes> createState() => _ProductTypesState();
}

class _ProductTypesState extends State<ProductTypes> {
  String? selectedProductTypeId;
  @override
  Widget build(BuildContext context) {
    // horizontal list of product types
    return SizedBox(
      height: 120,
      width: widget.size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productTypes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // select product type
              setState(() {
                selectedProductTypeId = widget.productTypes[index].id;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          border: Border.all(
                              color: selectedProductTypeId ==
                                      widget.productTypes[index].id
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomImage(
                              imageUrl: widget.productTypes[index].imageUrl),
                        ),
                      ),
                    ),
                    gapH8,
                    Text(widget.productTypes[index].name,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProdcutColos extends StatefulWidget {
  const ProdcutColos({
    super.key,
    required this.colors,
    required this.context,
    required this.size,
  });

  final List<String> colors;
  final BuildContext context;
  final Size size;

  @override
  State<ProdcutColos> createState() => _ProdcutColosState();
}

class _ProdcutColosState extends State<ProdcutColos> {
  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    // horizontal list of product types
    return SizedBox(
      height: 40,
      width: widget.size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // select product type
              setState(() {
                selectedColor = widget.colors[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 40,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    border: Border.all(
                        color: selectedColor == widget.colors[index]
                            ? Theme.of(context).primaryColor
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        child: DecoratedBox(
                      decoration: BoxDecoration(
                        // color: Theme.of(context).primaryColor,
                        color: widget.colors[index] == 'red'
                            ? Colors.red
                            : widget.colors[index] == 'blue'
                                ? Colors.blue
                                : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
