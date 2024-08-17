// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String postId;
  final String ?userId;
  final String username;
  final String? profilePictureUrl;
  final String comment;
  final Timestamp timestamp;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.username,
    required this.profilePictureUrl,
    required this.comment,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'postId': postId,
      'userId': userId,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'comment': comment,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] as String,
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      username: map['username'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      comment: map['comment'] as String,
      timestamp: map['timestamp'] is Timestamp
          ? map['timestamp'] as Timestamp
          : Timestamp.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
