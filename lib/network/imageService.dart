import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app_gallery/network/endpoints.dart'; 

class ImageService {
  final http.Client client;

  ImageService(this.client);

  final EndPoints endPoints = EndPoints();

  Future<List<Map<String, String>>> fetchImageData(int page) async {
    final List<Map<String, String>> imageInfo = [];

    try {
      final response = await http.get(Uri.parse(endPoints.getListOfImages() + '?page=$page')); 

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        for (final item in data) {
          final String imageUrl = item['download_url'] as String;
          final String authorName = item['author'] as String;
          imageInfo.add({
            'imageUrl': imageUrl,
            'authorName': authorName,
          });
        }

        return imageInfo;
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
