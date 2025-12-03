import 'package:get/get.dart';
import 'package:smart_mobile/src/data/repository/interface/product_repository.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';

import '../../details/view/details_view.dart';

class HomeController extends GetxController
    with StateMixin<List<ProductModel>> {
  final ProductRepository repository;

  HomeController({required this.repository});

  int size = 10;
  bool reachMax = false;

  List<ProductModel> products = <ProductModel>[].obs;
  List<ProductModel> filteredProducts = <ProductModel>[].obs;
  Rx<String> searchText = ''.obs;

  @override
  void onInit() {
    fetchProducts();

    super.onInit();
  }

  Future<void> fetchProducts() async {
    change(null, status: RxStatus.loading());

    final request = await repository.findProducts(limit: size);

    request.fold(
      (l) {
        change(null, status: RxStatus.error(l.message));
        products.clear();
        filteredProducts.clear();
      },
      (r) {
        products.assignAll(r);
        _applyFilter();
        change(r, status: RxStatus.success());
      },
    );
  }

  Future<void> loadMore() async {
    if (reachMax) return;

    size += 10;

    final request = await repository.findProducts(limit: size);

    request.fold((l) => change(null, status: RxStatus.error(l.message)), (r) {
      products.assignAll(r);
      reachMax = r.length < size;

      change(r, status: RxStatus.success());
    });
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final index = products.indexWhere((p) => p.id == product.id);

    if (index == -1) return;

    final updated = product.copyWith(isFavorite: !product.isFavorite);
    products[index] = updated;

    change(products, status: RxStatus.success());

    await repository.toggleFavorite(product.id);
  }

  void search(String query) {
    searchText.value = query;
    _applyFilter();
  }

  void _applyFilter() {
    final q = searchText.value.toLowerCase().trim();

    if (q.isEmpty) {
      filteredProducts.assignAll(products);
      return;
    }

    filteredProducts =
        products.where((p) {
          return p.title.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q);
        }).toList();
  }

  Future<void> goToDetails(ProductModel product) async {
    return await Get.to(
      ProductDetailsPage(
        product: product,
        onFavorite: () async => await toggleFavorite(product),
      ),
    );
  }
}
