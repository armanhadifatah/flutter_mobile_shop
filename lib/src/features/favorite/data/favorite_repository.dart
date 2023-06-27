import 'dart:async';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../configs/hive_box.dart';
import '../../products/domain/product.dart';

part 'favorite_repository.g.dart';

@riverpod
class FavoritesList extends _$FavoritesList {
  @override
  FutureOr<List<Product>> build() {
    fetchFavoriteList();
    return [];
  }

  Future<void> fetchFavoriteList() async {
    state = const AsyncValue.loading();
    final favoriteBox = await Hive.openBox(HiveBoxes.favorite);
    if (favoriteBox.isEmpty) {
      state = const AsyncValue.data([]);
    }
    final products = <Product>[];
    for (var i = 0; i < favoriteBox.length; i++) {
      final product = favoriteBox.getAt(i) as Product;
      products.add(product);
    }
    state = AsyncValue.data(products);
  }
}

class FavoritesRepository {
  const FavoritesRepository();

  // stream for if is favorite
  Stream<bool> isFavoriteStream(String productId) async* {
    final favoriteBox = await Hive.openBox(HiveBoxes.favorite);
    yield favoriteBox.containsKey(productId);
    yield* favoriteBox.watch(key: productId).map((event) {
      return event.value != null;
    });
  }

  Stream<List<Product>> fetchFavoriteListStream() async* {
    final favoriteBox = await Hive.openBox(HiveBoxes.favorite);

    var a = favoriteBox.watch().map((event) {
      print('#####################');
      final products = <Product>[];
      for (var i = 0; i < favoriteBox.length; i++) {
        final product = favoriteBox.getAt(i) as Product;
        products.add(product);
      }

      return products;
    });
    yield* a;
  }

  Future<bool> addToFavorite(Product product) async {
    final favoriteBox = await Hive.openBox(HiveBoxes.favorite);
    final isFavorite = favoriteBox.containsKey(product.id);
    if (isFavorite) {
      return false;
    }
    await favoriteBox.put(product.id, product);
    return true;
  }

  Future<bool> removeFromFavorite(Product product) async {
    final favoriteBox = await Hive.openBox(HiveBoxes.favorite);
    final isFavorite = favoriteBox.containsKey(product.id);
    if (!isFavorite) {
      return false;
    }
    await favoriteBox.delete(product.id);
    return true;
  }
}

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(FavoritesRepositoryRef ref) {
  return const FavoritesRepository();
}

@Riverpod(keepAlive: true)
Stream<List<Product>> favoritesListStream(FavoritesListStreamRef ref) {
  final favoritesRepository = ref.watch(favoritesRepositoryProvider);
  final favorites = favoritesRepository.fetchFavoriteListStream();
  return favorites;
}

@riverpod
Future<bool> addToFavoriteFuture(
    AddToFavoriteFutureRef ref, Product product) async {
  final favoritesRepository = ref.watch(favoritesRepositoryProvider);
  final isAdded = await favoritesRepository.addToFavorite(product);
  return isAdded;
}

@riverpod
Future<bool> removeFromFavoriteFuture(
    RemoveFromFavoriteFutureRef ref, Product product) async {
  final favoritesRepository = ref.watch(favoritesRepositoryProvider);
  final isRemoved = await favoritesRepository.removeFromFavorite(product);
  return isRemoved;
}

@riverpod
Stream<bool> isFavoriteStream(IsFavoriteStreamRef ref, Product product) {
  final favoritesRepository = ref.watch(favoritesRepositoryProvider);
  final isFavorite = favoritesRepository.isFavoriteStream(product.id);
  return isFavorite;
}
