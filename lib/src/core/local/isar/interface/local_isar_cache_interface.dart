import 'package:smart_mobile/src/data/repository/models/product_model.dart';

abstract class LocalIsarCacheInterface {
  Future<List<ProductModel>> findProducts();

  Future<void> saveProducts(List<ProductModel> products);

  Future<void> clear();

  Future<void> toggleFavorite(int productId);

  Future<List<ProductModel>> getFavorites();
}
