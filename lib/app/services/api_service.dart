import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // If running Flask on your local machine and using Android emulator:
  final String _baseUrl = "http://10.0.2.2:5000"; 
  // If using a physical device, replace with your machine's network IP:
  // final String _baseUrl = "http://YOUR_MACHINE_IP:5000";

  Future<Map<String, dynamic>> predictDisease(File imageFile, String type) async {
    final uri = Uri.parse("$_baseUrl/predict");
    try {
      var request = http.MultipartRequest('POST', uri);
      
      // Add the type
      request.fields['type'] = type;
      
      // Add the file
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // This 'file' must match the key in your Flask app: request.files["file"]
          imageFile.path,
          // contentType: MediaType('image', 'jpeg'), // Optional: if your server requires specific content type
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        // Attempt to parse error message from API if available
        try {
            final errorJson = json.decode(responseBody);
            final errorMessage = errorJson['error'] ?? 'Unknown API error';
            return {'error': 'API Error (${response.statusCode}): $errorMessage'};
        } catch (e) {
            // If response is not JSON or doesn't have 'error' key
            return {'error': 'API Error (${response.statusCode}): $responseBody'};
        }
      }
    } catch (e) {
      // Catch-all for network errors or other exceptions
      return {'error': 'Failed to connect to the API: ${e.toString()}'};
    }
  }
}
