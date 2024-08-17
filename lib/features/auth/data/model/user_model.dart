// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String? id;
  final String username;
  final String? email;
  final String? profilePictureUrl;
  final String bio;
  final List? followers;
  final List? following;

  UserModel({
     this.id,
    required this.username,
     this.email,
    required this.profilePictureUrl,
    required this.bio,
     this.followers,
     this.following,
  });
  



  Map<String, dynamic> toUpload() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'profilePictureUrl': profilePictureUrl??'',
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.toGetData(DocumentSnapshot map) {
    var data = map.data() as Map<String, dynamic>;
    return UserModel(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      profilePictureUrl: data['profilePictureUrl'] as String,
      bio: data['bio'] as String,
      followers: data['followers'] as List,
      following: data['following'] as List,
    );

    
  }
  
factory UserModel.fromMap(Map<String, dynamic> map) {
    
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      bio: map['bio'] as String,
      followers: map['followers'] as List,
      following: map['following'] as List,
    );

    
  }







}
