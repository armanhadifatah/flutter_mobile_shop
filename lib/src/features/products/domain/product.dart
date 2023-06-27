import 'package:hive/hive.dart';

import 'product_type.dart';
part 'product.g.dart';

/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

@HiveType(typeId: 1)
class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.colors,
    required this.storages,
    required this.productTypes,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  ///  @HiveField(0)
  @HiveField(0)
  final ProductID id;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final List<String> colors;
  @HiveField(6)
  final List<String> storages;
  @HiveField(7)
  final List<ProductType> productTypes;

  final double avgRating;
  final int numRatings;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      colors: map['colors'] ?? [],
      storages: map['storages'] ?? [],
      productTypes: map['productTypes'] != null
          ? map['productTypes']
              .map((e) => ProductType(imageUrl: e['imageUrl'], name: e['name']))
          : [],
      avgRating: map['avgRating']?.toDouble() ?? 0.0,
      numRatings: map['numRatings']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'price': price,
        'colors': colors,
        'productTypes': productTypes, // <--
        'storages': storages,
        'avgRating': avgRating,
        'numRatings': numRatings,
      };

  Product copyWith({
    ProductID? id,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    List<String>? colors,
    List<String>? storages,
    double? avgRating,
    int? numRatings,
  }) {
    return Product(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      storages: storages ?? this.storages,
      colors: colors ?? this.colors,
      productTypes: productTypes,
      avgRating: avgRating ?? this.avgRating,
      numRatings: numRatings ?? this.numRatings,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        description,
        price,
        storages,
        colors,
        avgRating,
        numRatings
      ];

  @override
  bool? get stringify => true;
}
