import 'package:isar/isar.dart';

import '../../../../data/repository/models/product_model.dart';

part 'product_isar_model.g.dart';

@collection
class ProductIsarModel {
  ProductIsarModel({
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    this.isFavorite = false,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  int productId;

  late String title;
  late String description;
  late double price;
  late String thumbnail;
  bool isFavorite;

  factory ProductIsarModel.fromDomain(ProductModel product) {
    return ProductIsarModel(
      productId: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      thumbnail: product.thumbnail,
      isFavorite: product.isFavorite,
    );
  }

  ProductModel toDomain() {
    return ProductModel(
      id: productId,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
      isFavorite: isFavorite,
    );
  }
}
