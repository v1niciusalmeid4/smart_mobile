import 'package:get/get.dart';
import 'package:smart_mobile/src/modules/home/view/home_view.dart';

class AppRoutes {
  static const home = '/';
  static const productDetails = '/product';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
  ];
}
