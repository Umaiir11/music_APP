import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import '../models/audio_model.dart';

class AudioPlayerController extends GetxController {
  late AudioPlayer _audioPlayer;
  Rx<PlayerState> audioState = PlayerState.stopped.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  AudioSongModel? currentSong;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((Duration dur) {
      duration.value = dur;
    });

    // Manually update position using a periodic timer or player state check
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing || state == PlayerState.paused) {
        _updatePosition();
      }
      audioState.value = state;
    });
  }

  void _updatePosition() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _audioPlayer.getCurrentPosition().then((pos) {
        if (pos != null) {
          position.value = pos;
        }
      });
    });
  }

  Future<void> play(AudioSongModel song) async {
    if (currentSong == null || currentSong!.songUrl != song.songUrl) {
      currentSong = song;

      // Assuming songUrl is a local file path
      String url = song.songUrl!;

      // Create a Source object from the file path
      Source source = DeviceFileSource(url);

      await _audioPlayer.play(source);
    } else {
      await _audioPlayer.resume();
    }
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
