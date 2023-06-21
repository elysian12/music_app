import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/providers/firebase_provider.dart';
import 'package:music_app/models/album.dart';
import 'package:music_app/models/user.dart';
import 'package:music_app/modules/auth/controller/auth_controller.dart';

final favouriteTrackProvider = Provider<FavouriteTrackRepository>((ref) {
  return FavouriteTrackRepository(
    firestore: ref.watch(firestoreProvider),
    userModel: ref.watch(userProvider),
  );
});

class FavouriteTrackRepository {
  final FirebaseFirestore _firestore;
  final UserModel _userModel;

  FavouriteTrackRepository(
      {required FirebaseFirestore firestore, required UserModel userModel})
      : _firestore = firestore,
        _userModel = userModel;

  CollectionReference get _favourites => _firestore.collection('favourites');

  Future<bool> addToFavourtie(Track track) async {
    bool isExist = false;
    List<Track> tracks = [];
    var favouriteRef = await _favourites.doc(_userModel.uid).get();

    if (favouriteRef.exists) {
      var favouriteDocs =
          (favouriteRef.data() as Map<String, dynamic>)['tracks'] as List;

      for (var element in favouriteDocs) {
        tracks.add(Track.fromSnapShot(element));
      }
      isExist = tracks.contains(track);

      if (isExist) {
        return isExist;
      }
      tracks.add(track);
      await _favourites.doc(_userModel.uid).set({
        'tracks': tracks.map((e) => e.toMap()).toList(),
      });
    } else {
      tracks.add(track);
      await _favourites.doc(_userModel.uid).set({
        'tracks': tracks.map((e) => e.toMap()).toList(),
      });
    }
    return isExist;
  }
}
