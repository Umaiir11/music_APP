import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart'; // Ensure audioplayers import
import '../models/audio_model.dart';
import '../viewmodel/audio_controller.dart';

class CategorySongs extends StatelessWidget {
  final List<AudioSongModel> songs;
  final AudioPlayerController audioPlayerController = Get.put(AudioPlayerController());

  CategorySongs({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Songs'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          var song = songs[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                song.songName ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(song.categoryName ?? ''),
              tileColor: Colors.blueAccent.withOpacity(0.1), // Background color for the tile
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              onTap: () {
                audioPlayerController.play(song); // Play song on tap
                _showPlayerDialog(context, song); // Show player dialog on tap
              },
            ),
          );
        },
      ),
    );
  }

  void _showPlayerDialog(BuildContext context, AudioSongModel song) {
    Get.dialog(
      AlertDialog(
        title: Text(song.songName ?? ''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(song.categoryName ?? ''),
            SizedBox(height: 16),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (audioPlayerController.audioState.value == PlayerState.playing) {
                      audioPlayerController.pause();
                    } else {
                      audioPlayerController.play(song);
                    }
                  },
                  icon: Icon(audioPlayerController.audioState.value == PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Obx(() => Slider(
                    value: audioPlayerController.position.value.inSeconds.toDouble(),
                    min: 0.0,
                    max: audioPlayerController.duration.value.inSeconds.toDouble(),
                    onChanged: (double value) {
                      audioPlayerController.pause();
                      audioPlayerController.seek(Duration(seconds: value.toInt()));
                    },
                  )),
                ),
                SizedBox(width: 8),
                Obx(() => Text(
                  '${audioPlayerController.position.value.inMinutes}:${(audioPlayerController.position.value.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12),
                )),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              audioPlayerController.stop();
              Get.back(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
