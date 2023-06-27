import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_shop/src/features/favorite/presentation/sliver_favorite_grid.dart';

import '../../../routing/app_router.dart';

class FavoriteListScreen extends ConsumerWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(favoritesListProvider.notifier).fetchFavoriteList();
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverFavoritesGrid(
            key: const Key('sliver-favorite-grid'),
            onPressed: (BuildContext, id) {
              context
                  .pushNamed(AppRoute.product.name, pathParameters: {'id': id});
            },
          ),
        ],
      )),
    );
  }
}
