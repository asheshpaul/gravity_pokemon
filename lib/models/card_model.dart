class CardModel {
  final String name;
  final String imageUrl;
  final String type;
  final String setName;
  final String artist;
  final List<String> weaknesses;
  final List<String> attacks;

  CardModel({
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.setName,
    required this.artist,
    required this.weaknesses,
    required this.attacks,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'] ?? 'Unknown Name',
      imageUrl: json['images']?['small'] ?? '',
      type: json['types'] != null && json['types'].isNotEmpty
          ? json['types'][0]
          : 'Unknown',
      setName: json['set']?['name'] ?? 'Unknown Set',
      artist: json['artist'] ?? 'Unknown Artist',
      weaknesses: json['weaknesses'] != null
          ? List<String>.from(json['weaknesses']?.map((w) => w['type']) ?? [])
          : [],
      attacks: json['attacks'] != null
          ? List<String>.from(json['attacks']?.map((a) => a['name']) ?? [])
          : [],
    );
  }
}
