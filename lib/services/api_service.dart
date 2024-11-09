import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/card_model.dart';

class ApiService {
  final String apiUrl = "https://api.pokemontcg.io/v2/cards";

  Future<List<CardModel>> fetchData(String query) async {
    // Future<Map<String, dynamic>> fetchData(String query) async {
    final url = Uri.parse(
        '$apiUrl?${query.isEmpty ? 'page=1&pageSize=10' : 'q=set.name:$query'}');
    if (kDebugMode) {
      print('Fetching data from: $url');
    }
    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Response: ${response.body}');
      }
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => CardModel.fromJson(json)).toList();
      // return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      throw Exception('Failed to load data');
    }
  }

/*Future<Map<String, dynamic>> searchData(String query) async {
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
  }*/
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
