import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app_bindings.dart';
import 'src/app_routes.dart';
import 'src/core/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SmartMobileApp());
}

class SmartMobileApp extends StatefulWidget {
  const SmartMobileApp({super.key});

  @override
  State<SmartMobileApp> createState() => _SmartMobileAppState();
}

class _SmartMobileAppState extends State<SmartMobileApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: onInit(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        }

        return GetMaterialApp(
          title: 'Catálogo de produtos',
          debugShowCheckedModeBanner: false,
          initialBinding: AppBindings(),
          initialRoute: AppRoutes.home,
          getPages: AppPages.pages,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        );
      },
    );
  }

  Future<void> onInit() async {
    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open([ProductIsarModelSchema], directory: dir.path);

    Get.put<Isar>(isar, permanent: true);

    Get.put<LocalIsarCacheInterface>(LocalIsarCacheImpl(isar));

    return;
  }
}
