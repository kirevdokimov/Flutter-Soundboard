import 'package:flutter/material.dart';
import 'package:flutter_soundboard/Clip.dart';
import 'package:flutter_soundboard/ISoundPlayer.dart';
import 'package:flutter_soundboard/SoundPlayer.dart';
import 'package:flutter_soundboard/SoundStorage.dart';

class MainScreen extends StatefulWidget{

  State<StatefulWidget> createState() => new MainScreenState();

}

class MainScreenState extends State<StatefulWidget>{

  Clip short,middle,long;

  bool isLoaded;

  ISoundPlayer player;
  SoundStorage storage;

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    player = new SoundPlayer();

    storage = new SoundStorage();
    storage.getSoundPath('assets/scream.mp3').then((value){
      short = new Clip(start : 736, finish : 2300, soundPath: value);
      middle = new Clip(start : 3381, finish : 4685, soundPath: value);
      long = new Clip(start : 5458, finish : 7079, soundPath: value);
      setState(() {
        isLoaded = true;
        print('Clips are loaded');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Soundboard'), leading: new Icon(Icons.hearing)),
      body: getBody(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  Widget getBody(){
    return new RaisedButton(
            onPressed: () => isLoaded ? player.playClip(short) : null,
            child: new Text('Play A'));
  }


}