import 'dart:async';
import 'package:audioplayer/audioplayer.dart';

class SoundPlayer{

  AudioPlayer audio;

  SoundPlayer(){
    audio = new AudioPlayer();
    print('SoundPlayer loaded : ${audio.toString()}');
  }

  Future play(String filePath) async {
    await audio.stop(); // Stop previous
    return await audio.play(filePath);
  }

  void dispose() {
    audio.stop();
  }

}