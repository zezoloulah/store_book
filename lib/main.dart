import 'package:flutter/material.dart';

import 'package:store_book/core/service/local_data/local_service_sheard.dart';
import 'package:store_book/features/splash_screen/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(), home: SplashScreen());
  }
}
