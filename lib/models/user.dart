import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String photoUrl;
  final String uid;
  const UserModel({
    required this.name,
    required this.photoUrl,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? photoUrl,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      uid: map['uid'] as String,
    );
  }
  @override
  List<Object> get props => [name, photoUrl];
}
