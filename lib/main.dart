import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart'; // We will create this file next

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Guava Disease Recognition',
      initialRoute: AppPages.INITIAL, // Define initial route
      getPages: AppPages.routes, // Define app routes
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Changed to green for a fresh look
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'), // We'll use GetX routes instead
    );
  }
}
