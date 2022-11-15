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

final currentTrackDurationProvider = FutureProvider<Duration?>((ref) async {
  return ref.watch(audioPlayerProvider.notifier).getDuration();
});

final currentTrackPositionProvider = StreamProvider<Duration>((ref) {
  return ref.watch(audioPlayerProvider.notifier).playerPosition();
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

  Stream<Duration> playerPosition() {
    return _audioPlayer.onPositionChanged;
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

  void muteUnmute(bool isMute) {
    if (isMute) {
      _audioPlayer.setVolume(1);
    } else {
      _audioPlayer.setVolume(0);
    }
  }

  Future<Duration?> getDuration() async {
    return await _audioPlayer.getDuration();
  }
}
