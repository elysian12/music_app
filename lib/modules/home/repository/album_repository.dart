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

  Future<FutureEither<List<Album>>> getLofiAlbums() async {
    List<Album> albums = [];

    List<String> lofiIds = [
      '7nmV3mTa1h0Bqi5DFzyYFi',
      '2AlygPiZ2YcMsVAku4xHWH',
      '0OqGNoguOy3MODEVsGNyMK',
      '0q7bYBmJ27h6GW4m3dWPPC',
      '1HeX4SmCFW4EPHQDvHgrVS',
      '6zwucxlWusEUCZt6DeQJCu',
    ];

    try {
      for (var element in lofiIds) {
        try {
          final newReleaseUrl =
              Uri.parse('https://api.spotify.com/v1/albums/$element');

          var response = await http.get(
            newReleaseUrl,
            headers: {'Authorization': 'Bearer $token'},
          );

          if (response.statusCode == 200) {
            var responseBody = jsonDecode(response.body);

            albums.add(Album.fromMap(responseBody));

            log(albums.length.toString());
          } else {
            throw 'SomeThing went wrong';
          }
        } catch (e) {
          return left(Failure(e.toString()));
        }
      }
      return right(albums);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<FutureEither<List<Track>>> getAlbumTrack(Album album) async {
    List<Track> tracks = [];
    final url =
        Uri.parse('https://api.spotify.com/v1/albums/${album.id}/tracks');

    try {
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        (responseBody['items'] as List).forEach(
          (element) {
            tracks.add(Track.fromMap(element, album.image));
          },
        );

        return right(tracks);
      } else {
        throw 'SomeThing went wrong';
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
