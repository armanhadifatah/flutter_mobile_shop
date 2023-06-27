// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesRepositoryHash() =>
    r'6ec33955b4a96669259f5eaed965c026853d9fe4';

/// See also [favoritesRepository].
@ProviderFor(favoritesRepository)
final favoritesRepositoryProvider = Provider<FavoritesRepository>.internal(
  favoritesRepository,
  name: r'favoritesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesRepositoryRef = ProviderRef<FavoritesRepository>;
String _$favoritesListStreamHash() =>
    r'4920455a340a90443a73d67fefbce837c33b1c45';

/// See also [favoritesListStream].
@ProviderFor(favoritesListStream)
final favoritesListStreamProvider = StreamProvider<List<Product>>.internal(
  favoritesListStream,
  name: r'favoritesListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesListStreamRef = StreamProviderRef<List<Product>>;
String _$addToFavoriteFutureHash() =>
    r'6737f476b0b9c52491d7be906cecf46a6dc747e7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef AddToFavoriteFutureRef = AutoDisposeFutureProviderRef<bool>;

/// See also [addToFavoriteFuture].
@ProviderFor(addToFavoriteFuture)
const addToFavoriteFutureProvider = AddToFavoriteFutureFamily();

/// See also [addToFavoriteFuture].
class AddToFavoriteFutureFamily extends Family<AsyncValue<bool>> {
  /// See also [addToFavoriteFuture].
  const AddToFavoriteFutureFamily();

  /// See also [addToFavoriteFuture].
  AddToFavoriteFutureProvider call(
    Product product,
  ) {
    return AddToFavoriteFutureProvider(
      product,
    );
  }

  @override
  AddToFavoriteFutureProvider getProviderOverride(
    covariant AddToFavoriteFutureProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addToFavoriteFutureProvider';
}

/// See also [addToFavoriteFuture].
class AddToFavoriteFutureProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addToFavoriteFuture].
  AddToFavoriteFutureProvider(
    this.product,
  ) : super.internal(
          (ref) => addToFavoriteFuture(
            ref,
            product,
          ),
          from: addToFavoriteFutureProvider,
          name: r'addToFavoriteFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addToFavoriteFutureHash,
          dependencies: AddToFavoriteFutureFamily._dependencies,
          allTransitiveDependencies:
              AddToFavoriteFutureFamily._allTransitiveDependencies,
        );

  final Product product;

  @override
  bool operator ==(Object other) {
    return other is AddToFavoriteFutureProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$removeFromFavoriteFutureHash() =>
    r'b6aa9ce836bb97695f52cef58df9befac14be207';
typedef RemoveFromFavoriteFutureRef = AutoDisposeFutureProviderRef<bool>;

/// See also [removeFromFavoriteFuture].
@ProviderFor(removeFromFavoriteFuture)
const removeFromFavoriteFutureProvider = RemoveFromFavoriteFutureFamily();

/// See also [removeFromFavoriteFuture].
class RemoveFromFavoriteFutureFamily extends Family<AsyncValue<bool>> {
  /// See also [removeFromFavoriteFuture].
  const RemoveFromFavoriteFutureFamily();

  /// See also [removeFromFavoriteFuture].
  RemoveFromFavoriteFutureProvider call(
    Product product,
  ) {
    return RemoveFromFavoriteFutureProvider(
      product,
    );
  }

  @override
  RemoveFromFavoriteFutureProvider getProviderOverride(
    covariant RemoveFromFavoriteFutureProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'removeFromFavoriteFutureProvider';
}

/// See also [removeFromFavoriteFuture].
class RemoveFromFavoriteFutureProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeFromFavoriteFuture].
  RemoveFromFavoriteFutureProvider(
    this.product,
  ) : super.internal(
          (ref) => removeFromFavoriteFuture(
            ref,
            product,
          ),
          from: removeFromFavoriteFutureProvider,
          name: r'removeFromFavoriteFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeFromFavoriteFutureHash,
          dependencies: RemoveFromFavoriteFutureFamily._dependencies,
          allTransitiveDependencies:
              RemoveFromFavoriteFutureFamily._allTransitiveDependencies,
        );

  final Product product;

  @override
  bool operator ==(Object other) {
    return other is RemoveFromFavoriteFutureProvider &&
        other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$isFavoriteStreamHash() => r'b7fb0fd91fc453576d5b6cd4a83e8c9980c7d0ea';
typedef IsFavoriteStreamRef = AutoDisposeStreamProviderRef<bool>;

/// See also [isFavoriteStream].
@ProviderFor(isFavoriteStream)
const isFavoriteStreamProvider = IsFavoriteStreamFamily();

/// See also [isFavoriteStream].
class IsFavoriteStreamFamily extends Family<AsyncValue<bool>> {
  /// See also [isFavoriteStream].
  const IsFavoriteStreamFamily();

  /// See also [isFavoriteStream].
  IsFavoriteStreamProvider call(
    Product product,
  ) {
    return IsFavoriteStreamProvider(
      product,
    );
  }

  @override
  IsFavoriteStreamProvider getProviderOverride(
    covariant IsFavoriteStreamProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFavoriteStreamProvider';
}

/// See also [isFavoriteStream].
class IsFavoriteStreamProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [isFavoriteStream].
  IsFavoriteStreamProvider(
    this.product,
  ) : super.internal(
          (ref) => isFavoriteStream(
            ref,
            product,
          ),
          from: isFavoriteStreamProvider,
          name: r'isFavoriteStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isFavoriteStreamHash,
          dependencies: IsFavoriteStreamFamily._dependencies,
          allTransitiveDependencies:
              IsFavoriteStreamFamily._allTransitiveDependencies,
        );

  final Product product;

  @override
  bool operator ==(Object other) {
    return other is IsFavoriteStreamProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$favoritesListHash() => r'0987465c092bdb608c3aec86b7153515f49ad8a9';

/// See also [FavoritesList].
@ProviderFor(FavoritesList)
final favoritesListProvider =
    AutoDisposeAsyncNotifierProvider<FavoritesList, List<Product>>.internal(
  FavoritesList.new,
  name: r'favoritesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritesList = AutoDisposeAsyncNotifier<List<Product>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
