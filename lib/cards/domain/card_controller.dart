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
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await ApiService().fetchData(query: searchQuery.value);
      cardList.assignAll(data['data']);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void updateSearchQuery(String query) {
    if (kDebugMode) {
      print('Updating search query: $query');
    }
    searchQuery(query);
    fetchData();
  }
}
