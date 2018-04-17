import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundStorage{

//  Future<String> _hasInPrefs(String assetPath){
//    return new Future(()=>'S');
//  }

  final soundAssetPath = <String>[
    'assets/sounds/short.wav',
    'assets/sounds/middle.wav',
    'assets/sounds/long.wav'
  ];

  Future<SharedPreferences> prefs;

  SoundStorage(){
    prefs = SharedPreferences.getInstance();
  }

  Future<List<String>> loadSounds() async{
    List<String> filePaths = new List<String>();
    await Future.forEach(soundAssetPath, (assetPath) async {
      final path = await getSoundPath(assetPath);
      filePaths.add(path);
      print('Sound $path added');
    });
    return filePaths;
  }

  Future<String> getSoundPath(String assetPath) async{
    final pref = (await prefs);
    final value = pref.getString(assetPath);
    if(value != null){
      print('Loading from shared_pref');
      return value;
    }else{
      print('Loading from assets');
      final path = await _assetPathToFilePath(assetPath);
      pref.setString(assetPath, path);
      return path;
    }
  }

  /// Writes new file to [tempPath] with byte data from asset and returns it.
  Future<String> _assetPathToFilePath(String assetPath) async{
    final name = assetPath.hashCode.toString();
    final tempPath = (await getTemporaryDirectory()).path;
    final file = new File('$tempPath/$name');
    final rawAsset = await rootBundle.load(assetPath);
    // TODO Handle io errors
    await file.writeAsBytes(rawAsset.buffer.asUint8List());
    return file.path;
  }

}