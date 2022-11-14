import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import 'package:music_app/common/constants/faliure.dart';
import 'package:music_app/common/constants/type_defs.dart';
import 'package:music_app/models/album.dart';

final albumRepositoryProvider =
    Provider.family<AlbumRepository, String>((ref, token) {
  return AlbumRepository(token: token);
});

class AlbumRepository {
  final String token;
  AlbumRepository({
    required this.token,
  });

  final newReleaseUrl =
      Uri.parse('https://api.spotify.com/v1/browse/new-releases');

  Future<FutureEither<List<Album>>> getNewRelease() async {
    List<Album> albums = [];

    try {
      var response = await http.get(
        newReleaseUrl,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        (responseBody['albums']['items'] as List).forEach(
          (element) {
            albums.add(Album.fromMap(element));
          },
        );

        log(albums.length.toString());

        return right(albums);
      } else {
        throw 'SomeThing went wrong';
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
