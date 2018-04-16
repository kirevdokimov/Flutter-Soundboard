import 'dart:async';

import 'package:flutter_soundboard/Deprecated/Clip.dart';
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
    await audio.stop(); // Stop previous
    return await audio.play(filePath);
  }

  @override
  Future playClip(Clip clip) async {
    await audio.stop(); // Stop previous
    await audio.play(clip.soundPath,isLocal: true);

    final seekValue = clip.start;
    print('seek value : $seekValue');
    await audio.seek(seekValue* 1.0);

    print('handle finish : ${clip.finish}');
    audio.setPositionHandler((Duration d) => check(d.inMilliseconds, clip.finish));
  }
  /// Check position for stop
  check(int current, int target){
    print('Playtime in mills : $current');
    if(current >= target ) audio.stop();
  }

  @override
  void dispose() {
    audio.stop();
  }

}