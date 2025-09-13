import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized (though onReady in controller handles navigation)
    Get.find<SplashController>(); 

    return const Scaffold(
      backgroundColor: Colors.white, // Or your desired splash background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Logo - Replace with your Image.asset
            FlutterLogo(size: 100.0), // Example: Image.asset('assets/images/logo.png', height: 100),
            SizedBox(height: 24),
            Text(
              'Guava Disease Recognition',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                // color: Colors.green, // Optional: if you want specific text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
