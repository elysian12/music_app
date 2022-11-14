import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:music_app/modules/auth/repository/auth_repository.dart';
import 'package:music_app/modules/home/repository/album_repository.dart';

import '../../../common/constants/faliure.dart';
import '../../../common/constants/type_defs.dart';
import '../../../models/album.dart';

final albumsControllerProvider =
    FutureProvider<FutureEither<List<Album>>>((ref) async {
  String token = '';
  final authRepository =
      await ref.watch(authRepositoryProvider).getSpotifyToken();
  authRepository.fold((l) => null, (r) => token = r);
  final albumProvider = ref.watch(albumRepositoryProvider(token));
  return albumProvider.getNewRelease();
});

final albumTrackControllerProvider =
    FutureProvider.family<Either<Failure, List<Track>>, String>(
        (ref, albumId) async {
  String token = '';
  final authRepository =
      await ref.watch(authRepositoryProvider).getSpotifyToken();
  authRepository.fold((l) => null, (r) => token = r);
  final albumProvider = ref.watch(albumRepositoryProvider(token));
  return albumProvider.getAlbumTrack(albumId);
});
