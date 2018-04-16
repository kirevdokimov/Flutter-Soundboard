import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class SoundStorage{

//  Future<String> _hasInPrefs(String assetPath){
//    return new Future(()=>'S');
//  }

  Future<String> getSoundPath(String assetPath) async{
    return await _assetPathToFilePath(assetPath);
  }

  /// Writes new file to [tempPath] with byte data from asset and returns it.
  Future<String> _assetPathToFilePath(String assetPath) async{
    final name = assetPath.hashCode.toString();
    final tempPath = (await getTemporaryDirectory()).path;
    // TODO delete mp3 if possible
    final file = new File('$tempPath/$name');
    final rawAsset = await rootBundle.load(assetPath);
    // TODO Handle io errors
    await file.writeAsBytes(rawAsset.buffer.asUint8List());
    return file.path;
  }

}