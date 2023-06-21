import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/album.dart';
import 'package:music_app/modules/home/repository/liked_tacks_repository.dart';

final favouriteNotifierProvider =
    StateNotifierProvider<FavouriteTrackNotifier, bool>((ref) {
  final trackRepository = ref.watch(favouriteTrackProvider);
  return FavouriteTrackNotifier(repository: trackRepository);
});

class FavouriteTrackNotifier extends StateNotifier<bool> {
  final FavouriteTrackRepository _trackRepository;
  FavouriteTrackNotifier({required FavouriteTrackRepository repository})
      : _trackRepository = repository,
        super(false);

  void favourite(Track track) async {
    bool isExit = await _trackRepository.addToFavourtie(track);
    state = !isExit;
  }
}
