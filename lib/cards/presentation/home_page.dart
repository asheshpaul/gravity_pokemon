import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/card_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardController cardController = Get.put(CardController());

  final TextEditingController searchController = TextEditingController();

  var isSearching = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => isSearching.value
            ? TextField(
          controller: searchController,
          onChanged: (value) => cardController.updateSearchQuery(value),
          decoration: const InputDecoration(
            hintText: 'Search Pokémon...',
            border: InputBorder.none,
          ),
          autofocus: true,
        )
            : const Text('Pokémon Cards')),
        actions: [
          IconButton(
            icon: Obx(() => Icon(isSearching.value ? Icons.close : Icons.search)),
            onPressed: () {
              if (isSearching.value) {
                searchController.clear();
                cardController.fetchData();
                isSearching(false);
              } else {
                isSearching(true);
              }
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (cardController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (cardController.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${cardController.errorMessage}'));
          } else if (cardController.cardList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: cardController.cardList.length,
              itemBuilder: (context, index) {
                var card = cardController.cardList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/details', arguments: card);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Flexible(
                          child: CachedNetworkImage(
                            imageUrl: card['images']['small'],
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            card['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
