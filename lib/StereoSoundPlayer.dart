import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:path_provider/path_provider.dart';
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
    // TODO: implement dispose
  }

  @override
  Future play(String assetPath) async {
    await _stereo.load(assetPath);
    await _stereo.play();
  }

  @override
  Future playClip(Clip clip) {
    // TODO: implement playClip
  }

}