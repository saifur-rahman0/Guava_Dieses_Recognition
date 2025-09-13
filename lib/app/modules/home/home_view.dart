import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guava Disease Recognition'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.pickedImage.value != null) {
                  return Image.file(
                    controller.pickedImage.value!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('No image selected')),
                  );
                }
              }),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  controller.showImageSourceDialog();
                },
                icon: const Icon(Icons.image_search),
                label: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'leaf',
                        groupValue: controller.selectedType.value,
                        onChanged: (value) {
                          if (value != null) controller.setSelectedType(value);
                        },
                      ),
                      const Text('Leaf'),
                      Radio<String>(
                        value: 'fruit',
                        groupValue: controller.selectedType.value,
                        onChanged: (value) {
                          if (value != null) controller.setSelectedType(value);
                        },
                      ),
                      const Text('Fruit'),
                    ],                  
                  )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return ElevatedButton.icon(
                    onPressed: () {
                       controller.recognizeDisease();
                    },
                    icon: const Icon(Icons.science_outlined),
                    label: const Text('Recognize Disease'),
                    style: ElevatedButton.styleFrom(
                        // primary: Colors.green // deprecated
                        backgroundColor: Colors.green
                        ),
                  );
                }
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.predictionResult.value != null) {
                  return Text(
                    controller.predictionResult.value!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  );
                }
                return const SizedBox.shrink(); // Empty space if no result
              }),
            ],
          ),
        ),
      ),
    );
  }
}
