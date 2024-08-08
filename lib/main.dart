import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neversitup_app/core/theme/theme.dart';
import 'package:neversitup_app/di/di.dart';
import 'package:neversitup_app/neversitup_app.dart';
import 'package:neversitup_app/product/domain/product_provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
            create: (context) => GetIt.instance.get(),
          )
        ],
        child: const NeversitupApp(),
      ),
    );
  }
}
