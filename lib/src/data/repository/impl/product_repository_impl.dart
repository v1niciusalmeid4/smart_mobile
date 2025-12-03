import 'package:dartz/dartz.dart';
import 'package:smart_mobile/src/core/dio/interface/dio_interface.dart';
import 'package:smart_mobile/src/core/dio/models/dio_response.dart';
import 'package:smart_mobile/src/core/exceptions/failure.dart';
import 'package:smart_mobile/src/core/local/isar/interface/local_isar_cache_interface.dart';
import 'package:smart_mobile/src/data/repository/interface/product_repository.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';

class ProductRepositoryEndpoints {
  static String products = '/products';
}

class ProductRepositoryImpl implements ProductRepository {
  final DioInterface dio;
  final LocalIsarCacheInterface localCache;

  ProductRepositoryImpl({required this.dio, required this.localCache});

  @override
  Future<Either<Failure, List<ProductModel>>> findProducts({int? limit}) async {
    try {
      String path = ProductRepositoryEndpoints.products;

      if (limit != null) {
        path += '?limit=$limit';
      }

      DioResponse response = await dio.get(path);

      final data = response.data['products'] as List<dynamic>;

      List<ProductModel> products = data.map(ProductModel.fromMap).toList();

      final cachedProducts = await localCache.findProducts();

      final favoriteIds =
          cachedProducts.where((p) => p.isFavorite).map((p) => p.id).toSet();

      products =
          products
              .map((p) => p.copyWith(isFavorite: favoriteIds.contains(p.id)))
              .toList();

      await localCache.saveProducts(products);

      return Right(products);
    } catch (e) {
      final cached = await localCache.findProducts();

      if (cached.isNotEmpty) {
        return Right(cached);
      }

      return Left(Failure(message: '$e'));
    }
  }

  @override
  Future<void> toggleFavorite(int productId) {
    return localCache.toggleFavorite(productId);
  }

  @override
  Future<List<ProductModel>> getFavorites() {
    return localCache.getFavorites();
  }
}
