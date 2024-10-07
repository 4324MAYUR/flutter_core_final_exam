import 'package:core_flutter_final_exam/screen/detail_page/detail_page.dart';
import 'package:core_flutter_final_exam/screen/home_page/home_page.dart';
import 'package:core_flutter_final_exam/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.detail_page: (context) => const DetailPage(),
      },
    );
  }
}