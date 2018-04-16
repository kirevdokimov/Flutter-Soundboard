import 'dart:async';
import 'package:stereo/stereo.dart';

import 'package:flutter_soundboard/Clip.dart';
import 'package:flutter_soundboard/ISoundPlayer.dart';

class StereoSoundPlayer extends ISoundPlayer{

  Stereo _stereo;


  StereoSoundPlayer(){
    _stereo = new Stereo();
  }

//  Future _playFile(String file, [bool fromAppDir = true]) async {
//
//    try {
//      await _stereo.load('$dir$file');
//    } on StereoFileNotPlayableException {
////      var alert = new AlertDialog(
////              title: new Text('File not playable'),
////              content: new Text('The file you specified is not playable.'));
////
////      showDialog(context: context, child: alert);
//    }
//  }

  @override
  void dispose() {
    _stereo.stop();
  }

  @override
  Future play(String filePath) async {
    await _stereo.stop();
    await _stereo.load(filePath);
    await _stereo.play();
  }

  @override
  Future playClip(Clip clip) async{
    await _stereo.load(clip.soundPath);
    await _stereo.play();
    await _stereo.seek(new Duration(milliseconds: clip.start));
    print('Start : ${clip.start}');
    _stereo.positionHandler = (){
      print('Position : ${_stereo.position.inMilliseconds}');
      if(_stereo.position.inMilliseconds >= clip.finish){
        _stereo.stop();
        print('Finish : ${clip.finish}');
      }
    };
  }

}