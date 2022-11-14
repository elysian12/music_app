import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/widgets/drawer.dart';
import 'package:music_app/modules/home/screens/album_tracks_screen.dart';

import '../controller/album_controller.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var albums = ref.watch(albumsControllerProvider);
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => openDrawer(context),
            icon: Image.asset(
              'assets/ham.png',
              scale: 4,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Recommended for You',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 260,
              width: MediaQuery.of(context).size.width,
              child: albums.when(
                  data: (data) {
                    return data.fold(
                        (l) => Center(
                              child: Text(l.message.toString()),
                            ),
                        (albums) => ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.all(8),
                                height: 250,
                                width: 190,
                                child: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, AlbumTrackSceen.routeName,
                                      arguments: albums[index]),
                                  child: Column(
                                    children: [
                                      Image.network(albums[index].image),
                                      const SizedBox(height: 10),
                                      Text(
                                        albums[index].name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        albums[index].artistName,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
