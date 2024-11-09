import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/card_model.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CardModel card = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: card.name,
                child: CachedNetworkImage(
                  imageUrl: card.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Name: ${card.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Type: ${card.type}', style: const TextStyle(fontSize: 16)),
            Text('Set: ${card.setName}', style: const TextStyle(fontSize: 16)),
            Text('Artist: ${card.artist}',
                style: const TextStyle(fontSize: 16)),
            Text('Weaknesses: ${card.weaknesses.join(', ')}',
                style: const TextStyle(fontSize: 16)),
            Text('Attacks: ${card.attacks.join(', ')}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
