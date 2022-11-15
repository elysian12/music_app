import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:music_app/models/album.dart';
import 'package:music_app/modules/home/controller/audio_player_constroller.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  final Track track;
  static const String routeName = '/audio-player-screen';
  const AudioPlayerScreen({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  double value = 0;
  bool isMute = false;

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(audioPlayerProvider);
    final duration = ref.watch(currentTrackDurationProvider);
    final position = ref.watch(currentTrackPositionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playing Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.track.imageUrl!,
                height: 260,
                width: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.track.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.track.artistName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    ref.watch(audioPlayerProvider.notifier).muteUnmute(isMute);
                    setState(() {
                      isMute = !isMute;
                    });
                  },
                  icon: Icon(
                    isMute ? Icons.volume_mute : Icons.volume_down_outlined,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.repeat,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shuffle,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                position.when(
                  data: (Duration data) => Text(
                    '00:${data.inSeconds}',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  error: (Object error, StackTrace stackTrace) => Text(
                    error.toString(),
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  loading: () => Text(
                    '00:00',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                duration.when(
                  data: (data) {
                    return Text(
                      '00:${data!.inSeconds}',
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text(
                    error.toString(),
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  loading: () => Text(
                    '00:00',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            duration.when(
                data: (data) {
                  return position.when(
                    data: (Duration position) {
                      return Slider(
                        min: 0.0,
                        max: data!.inSeconds.toDouble(),
                        activeColor: Theme.of(context).indicatorColor,
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (Object error, StackTrace stackTrace) => Text(
                      error.toString(),
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => Text(
                      error.toString(),
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    size: 38,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    if (player) {
                      ref.watch(audioPlayerProvider.notifier).pause();
                    } else {
                      ref.watch(audioPlayerProvider.notifier).resume();
                    }
                  },
                  icon: Icon(
                    !player ? Icons.play_arrow : Icons.pause,
                    size: 38,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    size: 38,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
