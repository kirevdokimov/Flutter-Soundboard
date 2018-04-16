import 'dart:async';
import 'Clip.dart';

// There is no interface keyword in Dart 2.
abstract class ISoundPlayer {
  /// Do [assetPath] hello
  Future play(String assetPath);

  Future playClip(Clip clip);

  void dispose();
}