// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final String? userId;
  final String? username;
  final String? profilePictureUrl;
  final String? imageUrl;
  final String? caption;
  final Timestamp timestamp;
  final List? likes;

  PostModel(
      {required this.postId,
      required this.username,
      required this.profilePictureUrl,
      required this.userId,
      required this.imageUrl,
      required this.caption,
      required this.timestamp,
      required this.likes});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'userId': userId,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'imageUrl': imageUrl,
      'caption': caption,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'likes': likes??[],
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    // var data = map.data() as Map<String, dynamic>;
    return PostModel(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] as String,
      caption: map['caption'] as String,
      timestamp:map['timestamp'] is Timestamp
          ? map['timestamp'] as Timestamp
          : Timestamp.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      likes: map['likes'] as List,
      profilePictureUrl: map['profilePictureUrl'] as String,
      username: map['username'] as String,
    );
  }
}
