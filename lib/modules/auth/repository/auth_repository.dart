import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_app/common/constants/faliure.dart';
import 'package:music_app/common/constants/type_defs.dart';
import 'package:music_app/common/providers/firebase_provider.dart';
import 'package:music_app/models/user.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = firestore;

  CollectionReference get _users => _firestore.collection('users');

  Future<FutureEither<UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        throw 'Cancelled';
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user!.displayName!,
            photoUrl: userCredential.user!.photoURL!,
            uid: userCredential.user!.uid);
        await _users.doc(userModel.uid).set(userModel.toMap());
      } else {
        userModel = await _users
            .doc(userCredential.user!.uid)
            .snapshots()
            .map((event) =>
                UserModel.fromMap(event.data() as Map<String, dynamic>))
            .first;
      }
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Spotify AuthToken

  Future<FutureEither<String>> getSpotifyToken() async {
    Map<String, String> headers = {
      'Content-Type': "application/x-www-form-urlencoded",
      'Authorization':
          "Basic MjBiNGMxM2QzOGYyNGNiZjlkZWFlMzA4MjhhNjcwMzM6MzY5NDVhNjg4NWM4NGZjZjliZmQ3ODhiYmM5NTczNzQ="
    };

    var request = http.Request(
        'POST', Uri.parse('https://accounts.spotify.com/api/token'));
    request.bodyFields = {'grant_type': 'client_credentials'};

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(await response.stream.bytesToString());
      log(responseBody['access_token']);

      return right(responseBody['access_token']);
    } else {
      return left(Failure(response.reasonPhrase!));
    }
  }
}
