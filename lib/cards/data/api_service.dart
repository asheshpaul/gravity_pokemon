import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://api.pokemontcg.io/v2/cards";

  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse('$apiUrl?page=1&pageSize=10');
    if (kDebugMode) {
      print('Fetching data from: $url');
    }
    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Response: ${response.body}');
      }
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> searchData(String query) async {
    final url = Uri.parse('$apiUrl?q=set.name:$query');
    if (kDebugMode) {
      print('Searching data from: $url');
    }
    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Response: ${response.body}');
      }
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      throw Exception('Failed to load data');
    }
  }
  // final String apiUrl = "https://api.pokemontcg.io/v2/cards?page=1&pageSize=10";

  /*Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }*/
}