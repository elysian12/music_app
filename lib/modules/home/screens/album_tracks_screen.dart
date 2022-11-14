import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/album.dart';

import '../controller/album_controller.dart';

class AlbumTrackSceen extends ConsumerWidget {
  final Album album;
  static const String routeName = '/album-tracks-screen';
  const AlbumTrackSceen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tracks = ref.watch(albumTrackControllerProvider(album.id));
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
            (r) => ListView.builder(
              itemCount: r.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(album.image),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                  title: Text(r[index].name),
                  subtitle: Text(r[index].artistName),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
