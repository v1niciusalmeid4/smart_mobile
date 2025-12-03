import 'package:get/get.dart';
import 'package:smart_mobile/src/core/dio/impl/dio_impl.dart';
import 'package:smart_mobile/src/core/dio/interface/dio_interface.dart';
import 'package:smart_mobile/src/core/local/isar/interface/local_isar_cache_interface.dart';
import 'package:smart_mobile/src/data/repository/impl/product_repository_impl.dart';

import '../../../data/repository/interface/product_repository.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<DioInterface>(DioImpl());

    Get.put<ProductRepository>(
      ProductRepositoryImpl(
        dio: Get.find<DioInterface>(),
        localCache: Get.find<LocalIsarCacheInterface>(),
      ),
    );
  }
}
