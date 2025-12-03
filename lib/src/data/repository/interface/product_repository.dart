import 'package:smart_mobile/src/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> findProducts({int? limit});
  Future<void> toggleFavorite(int productId);
  Future<List<ProductModel>> getFavorites();
}
