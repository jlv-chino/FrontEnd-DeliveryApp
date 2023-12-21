import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoflutter/src/pages/login/login_page.dart';
import 'package:proyectoflutter/src/pages/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery Udemy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage())
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          secondary: Colors.amberAccent,
          primary: Colors.amber,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.amber,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.white,
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
