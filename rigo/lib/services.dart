import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rigo/constants.dart';

class ProxyMaker {
  Future<List<dynamic>> getImages(String url) async {
    Map<String, dynamic> body = {
      "url": url,
    };
    final response = await http.post(
      Uri.parse("$apiURL/cardimages"),
      body: body,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to get images");
    }
  }
}
