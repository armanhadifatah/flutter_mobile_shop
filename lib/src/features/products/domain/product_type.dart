import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'product_type.g.dart';

@HiveType(typeId: 2)
class ProductType {
  @HiveField(0)
  String name;
  @HiveField(1)
  String imageUrl;
  @HiveField(2)
  String id = UniqueKey().toString();

  ProductType({
    required this.name,
    required this.imageUrl,
  });
}
