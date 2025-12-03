import 'package:isar/isar.dart';
import 'package:smart_mobile/src/core/local/isar/models/product_isar_model.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';

import '../interface/local_isar_cache_interface.dart';

class LocalIsarCacheImpl implements LocalIsarCacheInterface {
  final Isar _isar;

  LocalIsarCacheImpl(this._isar);

  @override
  Future<List<ProductModel>> findProducts() async {
    final entities = await _isar.productIsarModels.where().findAll();
    return entities.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> saveProducts(List<ProductModel> products) async {
    final existing = await _isar.productIsarModels.where().findAll();
    final favoriteById = <int, bool>{
      for (final e in existing) e.productId: e.isFavorite,
    };

    final entities =
        products.map((product) {
          final entity = ProductIsarModel.fromDomain(product);

          entity.isFavorite =
              favoriteById[entity.productId] ?? product.isFavorite;

          return entity;
        }).toList();

    await _isar.writeTxn(() async {
      await _isar.productIsarModels.clear();
      await _isar.productIsarModels.putAll(entities);
    });
  }

  @override
  Future<void> clear() async {
    await _isar.writeTxn(() async {
      await _isar.productIsarModels.clear();
    });
  }

  @override
  Future<void> toggleFavorite(int productId) async {
    await _isar.writeTxn(() async {
      final entity =
          await _isar.productIsarModels
              .where()
              .productIdEqualTo(productId)
              .findFirst();

      if (entity == null) return;

      entity.isFavorite = !entity.isFavorite;
      await _isar.productIsarModels.put(entity);
    });
  }

  @override
  Future<List<ProductModel>> getFavorites() async {
    final entities =
        await _isar.productIsarModels
            .filter()
            .isFavoriteEqualTo(true)
            .findAll();

    return entities.map((e) => e.toDomain()).toList();
  }
}
