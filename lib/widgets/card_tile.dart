import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/card_model.dart';

class CardTile extends StatelessWidget {
  final CardModel card;

  const CardTile({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.55,
              child: CachedNetworkImage(
                imageUrl: card.imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              card.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
