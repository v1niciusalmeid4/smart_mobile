import 'package:get/get.dart';
import 'package:smart_mobile/src/core/dio/impl/dio_impl.dart';
import 'package:smart_mobile/src/core/dio/interface/dio_interface.dart';
import 'package:smart_mobile/src/core/local/isar/interface/local_isar_cache_interface.dart';
import 'package:smart_mobile/src/data/repository/impl/product_repository_impl.dart';
import 'package:smart_mobile/src/data/repository/interface/product_repository.dart';
import 'package:smart_mobile/src/modules/home/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioInterface>(() => DioImpl(), fenix: true);

    Get.put<ProductRepository>(
      ProductRepositoryImpl(
        dio: Get.find<DioInterface>(),
        localCache: Get.find<LocalIsarCacheInterface>(),
      ),
    );

    Get.put<HomeController>(
      HomeController(repository: Get.find<ProductRepository>()),
    );
  }
}
