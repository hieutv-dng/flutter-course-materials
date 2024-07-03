import 'package:flutflix_tutorial/core/my_theme.dart';
import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'screens/main/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initService();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutflix',
      theme: myThemeData,
      home: const MainPage(),
      builder: EasyLoading.init(),
    );
  }
}

Future<void> initService() async {
  Get.put(AuthService());
  Get.put(FavoriteService());
}
