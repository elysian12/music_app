import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/album.dart';

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerController, bool>((ref) {
  return AudioPlayerController();
});

final currentTrackProvider = StateNotifierProvider<CurrentTrack, Track?>((ref) {
  return CurrentTrack();
});

class CurrentTrack extends StateNotifier<Track?> {
  CurrentTrack() : super(null);

  void update(Track track) {
    state = track;
  }
}

class AudioPlayerController extends StateNotifier<bool> {
  AudioPlayerController() : super(false);

  final AudioPlayer _audioPlayer = AudioPlayer();

  void play(String url) async {
    state = true;
    await _audioPlayer.play(UrlSource(url));
  }

  void pause() async {
    await _audioPlayer.pause();
    state = false;
  }

  void resume() async {
    await _audioPlayer.resume();
    state = true;
  }

  void stop() async {
    await _audioPlayer.stop();
    state = false;
  }

  Future<Duration?> getDuration() async {
    return await _audioPlayer.getDuration();
  }

  Future<Duration?> getCurrentPosition() async {
    return await _audioPlayer.getCurrentPosition();
  }
}
