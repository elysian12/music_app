import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/album.dart';
import 'package:music_app/modules/home/controller/audio_player_constroller.dart';

import '../controller/album_controller.dart';
import '../widgets/audio_player.dart';

class AlbumTrackSceen extends ConsumerWidget {
  final Album album;
  static const String routeName = '/album-tracks-screen';
  const AlbumTrackSceen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tracks = ref.watch(albumTrackControllerProvider(album));
    var currenttracks = ref.watch(currentTrackProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(album.name),
      ),
      body: tracks.when(
        data: (data) {
          return data.fold(
            (l) => Center(
              child: Text(l.message.toString()),
            ),
            (r) {
              return ListView.builder(
                itemCount: r.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      ref.watch(currentTrackProvider.notifier).update(r[index]);
                      ref
                          .watch(audioPlayerProvider.notifier)
                          .play(r[index].previewUrl);
                    },
                    leading: Image.network(album.image),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                    title: Text(
                      r[index].name,
                      style: TextStyle(
                          color: currenttracks == null
                              ? null
                              : currenttracks.id == r[index].id
                                  ? Colors.green
                                  : null),
                    ),
                    subtitle: Text(
                      r[index].artistName,
                      style: TextStyle(
                          color: currenttracks == null
                              ? null
                              : currenttracks.id == r[index].id
                                  ? Colors.green
                                  : null),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: const MyAudioPlayer(),
    );
  }
}
