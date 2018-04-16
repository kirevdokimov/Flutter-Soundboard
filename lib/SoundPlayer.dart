import 'dart:async';

import 'package:flutter_soundboard/Clip.dart';
import 'package:flutter_soundboard/ISoundPlayer.dart';

import 'package:audioplayer/audioplayer.dart';

class SoundPlayer extends ISoundPlayer{

  AudioPlayer audio;

  SoundPlayer(){
    audio = new AudioPlayer();
    //audio.setDurationHandler((Duration d) => {});
    //audio.setPositionHandler((Duration  p) => {});


    print('SoundPlayer loaded : ${audio.toString()}');
  }

  @override
  Future play(String filePath) async {
    return await audio.play(filePath);
  }

  @override
  Future playClip(Clip clip) async {
    await audio.stop(); // Stop previous

    audio.setPositionHandler((Duration d) => check(d.inMilliseconds, clip.finish));
    await audio.play(clip.soundPath,isLocal: true);
    await audio.seek(clip.start*1000.0);
  }
  /// Check position for stop
  check(int current, int target){
    if(current >= target ) audio.stop();
  }

  @override
  void dispose() {
    audio.stop();
  }

}