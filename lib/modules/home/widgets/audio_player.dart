import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/audio_player_constroller.dart';

class MyAudioPlayer extends ConsumerWidget {
  const MyAudioPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTrack = ref.watch(currentTrackProvider);
    final player = ref.watch(audioPlayerProvider);
    return currentTrack != null
        ? Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                  top: BorderSide(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              )),
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentTrack.name),
                    Text(currentTrack.artistName),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (player) {
                      ref.watch(audioPlayerProvider.notifier).pause();
                    } else {
                      ref.watch(audioPlayerProvider.notifier).resume();
                    }
                  },
                  icon: Icon(!player ? Icons.play_arrow : Icons.pause),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
