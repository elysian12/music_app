import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class Track extends Equatable {
  final String name;
  final String id;
  final String artistName;
  final String previewUrl;
  String? imageUrl;

  Track({
    required this.name,
    required this.id,
    required this.artistName,
    required this.previewUrl,
    required this.imageUrl,
  });

  factory Track.fromMap(Map<String, dynamic> map, String imgUrl) {
    return Track(
      name: map['name'] as String,
      id: map['id'] as String,
      artistName: map['artists'][0]['name'],
      previewUrl: map['preview_url'] as String,
      imageUrl: imgUrl,
    );
  }

  factory Track.fromSnapShot(Map<String, dynamic> map) {
    return Track(
      name: map['name'] as String,
      id: map['id'] as String,
      artistName: map['artistName'],
      previewUrl: map['previewUrl'] as String,
      imageUrl: map['artistName'],
    );
  }

  Track copyWith({
    String? name,
    String? id,
    String? artistName,
    String? previewUrl,
    String? imageUrl,
  }) {
    return Track(
      name: name ?? this.name,
      id: id ?? this.id,
      artistName: artistName ?? this.artistName,
      previewUrl: previewUrl ?? this.previewUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'artistName': artistName,
      'previewUrl': previewUrl,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [name, imageUrl, id, artistName, previewUrl];
}
