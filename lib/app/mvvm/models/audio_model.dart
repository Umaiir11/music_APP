import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class AudioSongModel {
  final String? songName;
  final String? songUrl;
  final String? thumbnail;
  final String? categoryName;
  final Timestamp? timestamp;
  final File? file;

  AudioSongModel({
    required this.songName,
    required this.songUrl,
    this.thumbnail,
    this.timestamp,
    this.categoryName,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return {
      'songName': songName,
      'songUrl': songUrl,
      'thumbnail': thumbnail ?? '',
      'categoryName': categoryName ?? '',
      'timestamp': timestamp ?? Timestamp.now(),
    };
  }
}