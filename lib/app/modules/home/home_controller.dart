import 'dart:io'; // Required for File

import 'package:flutter/material.dart'; // Added for Get.snackbar theming
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/api_service.dart'; // Import ApiService

class HomeController extends GetxController {
  final count = 0.obs; // We can keep this or remove it later if not needed
  final pickedImage = Rx<File?>(null); // Observable for the picked image file
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker
  final ApiService _apiService = ApiService(); // Instance of ApiService

  final selectedType = 'leaf'.obs; // Observable for selected type, default to 'leaf'
  final predictionResult = Rx<String?>(null); // To store the API prediction result
  final isLoading = false.obs; // To manage loading state during API call

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pickedImage.value = null; // Clear the image on close
    predictionResult.value = null; // Clear prediction on close
    super.onClose();
  }

  void increment() => count.value++; // Example function

  void setSelectedType(String type) {
    selectedType.value = type;
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
      predictionResult.value = null; // Clear previous prediction
    } else {
      Get.snackbar('Image Selection', 'No image selected');
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage.value = File(image.path);
      predictionResult.value = null; // Clear previous prediction
    } else {
      Get.snackbar('Image Selection', 'No image captured');
    }
  }

  void showImageSourceDialog() {
    Get.defaultDialog(
      title: "Choose Image Source",
      middleText: "Would you like to pick an image from the gallery or camera?",
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            pickImageFromGallery();
          },
          child: const Text("Gallery"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            pickImageFromCamera();
          },
          child: const Text("Camera"),
        ),
      ],
    );
  }

  Future<void> recognizeDisease() async {
    if (pickedImage.value == null) {
      Get.snackbar('Error', 'Please select an image first.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isLoading.value = true;
    predictionResult.value = null;

    try {
      final result = await _apiService.predictDisease(pickedImage.value!, selectedType.value);
      if (result.containsKey('error')) {
        predictionResult.value = result['error'];
        Get.snackbar('API Error', result['error'] ?? 'An unknown error occurred',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        // Assuming your API returns { "type": "leaf", "prediction": "Some Disease" }
        final String apiType = result['type'] ?? 'N/A';
        final String apiPrediction = result['prediction'] ?? 'No prediction found';
        predictionResult.value = "Type: $apiType\nPrediction: $apiPrediction";
         Get.snackbar('Success', 'Disease recognized successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      predictionResult.value = "Failed to process the request: ${e.toString()}";
      Get.snackbar('Error', "Failed to process the request: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
