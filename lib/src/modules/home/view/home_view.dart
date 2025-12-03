import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mobile/src/core/components/pagination_component.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';
import 'package:smart_mobile/src/modules/home/widgets/product_item.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  List<ProductModel> get products =>
      controller.searchText.value.isNotEmpty
          ? controller.filteredProducts
          : controller.products;

  bool get reachMax =>
      controller.searchText.value.isNotEmpty ? true : controller.reachMax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: controller.search,
              decoration: const InputDecoration(
                hintText: 'Buscar produtos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      body: controller.obx(
        (_) => Obx(() => buildProducts),
        onLoading: const Center(child: CircularProgressIndicator.adaptive()),
        onEmpty: const Center(child: Text('Nenhum produto encontrado')),
        onError:
            (e) => Center(child: Text('Oops! Algo errado aconteceu =( $e)')),
      ),
    );
  }

  Widget get buildProducts => PaginationComponent(
    itemCount: products.length,
    reachMax: reachMax,
    onFetch: () async {
      if (controller.searchText.value.isEmpty) {
        await controller.loadMore();
      }
    },
    onPullRefresh: () => controller.fetchProducts(),
    builder: (context, index) {
      final product = products[index];

      return ProductItem(
        product: product,
        onFavorite: () => controller.toggleFavorite(product),
        onPressed: () => controller.goToDetails(product),
      );
    },
  );
}
