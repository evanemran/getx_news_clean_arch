import 'dart:convert';

import 'package:getx_news_clean_arch/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  Future<Map<String, dynamic>> fetchNews(String category) async {
    // Simulating an API response
    //ToDo
    final url = '${ApiConstants.baseUrl}${ApiConstants.headlines}?country=us&category=$category&apiKey=6600726d91554031a727674028102f84';
    final headers = {'Content-Type': 'application/json'};

    print("📡 Sending POST request to: $url");
    print("📩 Headers: $headers");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print("🔄 Response Code: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");

      return jsonDecode(response.body);

    } catch (e) {
      throw Exception();
    }
  }
}