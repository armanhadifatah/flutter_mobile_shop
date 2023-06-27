import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'firebase_options.dart';
import 'src/app_bootstrap.dart';
import 'src/app_bootstrap_firebase.dart';
import 'src/features/products/domain/product.dart';
import 'src/features/products/domain/product_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ProductTypeAdapter());
  final appBootstrap = AppBootstrap();
  final container = await createFirebaseProviderContainer();

  final root = appBootstrap.createRootWidget(container: container);
  runApp(root);
}
