import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/api_service.dart';

class CardController extends GetxController {
  var cardList = <dynamic>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    fetchData('');
    super.onInit();
  }

  void fetchData(String query) async {
    try {
      isLoading(true);
      var data = await ApiService().fetchData(query);
      cardList.assignAll(data['data']);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /*void searchData(String query) async {
    try {
      isLoading(true);
      var data = await ApiService().searchData(query);
      if (kDebugMode) {
        print('Searched data: $data');
      }
      cardList.assignAll(data['data']);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }*/

  void updateSearchQuery(String query) {
    if (kDebugMode) {
      print('Updating search query: $query');
    }
    searchQuery(query);
    fetchData(query);
    // searchData(query);
  }
}
