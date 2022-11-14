import 'dart:convert';

class Album {
  final String image;
  final String name;
  final String id;
  final String artistName;

  Album({
    required this.image,
    required this.name,
    required this.id,
    required this.artistName,
  });

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      image: (map['images'] as List).first['url'],
      name: map['name'] as String,
      id: map['id'] as String,
      artistName: map['artists'][0]['name'],
    );
  }
}
