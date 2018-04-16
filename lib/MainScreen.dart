import 'package:flutter/material.dart';
import 'package:flutter_soundboard/Clip.dart';
import 'package:flutter_soundboard/ISoundPlayer.dart';
import 'package:flutter_soundboard/SoundPlayer.dart';
import 'package:flutter_soundboard/SoundStorage.dart';
import 'package:flutter_soundboard/StereoSoundPlayer.dart';

class MainScreen extends StatefulWidget{

  State<StatefulWidget> createState() => new MainScreenState();

}

class MainScreenState extends State<StatefulWidget>{

  String short,middle,long;

  int loaded;

  ISoundPlayer player;
  SoundStorage storage;

  @override
  void initState() {
    super.initState();
    loaded = 0;
    player = new SoundPlayer();

    storage = new SoundStorage();
    storage.getSoundPath('assets/short.wav').then((value){
      short = value;
      setState(() {
        loaded++;
        if(isLoaded) print('Clips are loaded');
      });
    });

    storage.getSoundPath('assets/middle.wav').then((value){
      middle = value;
      setState(() {
        loaded++;
        if(isLoaded) print('Clips are loaded');
      });
    });
    storage.getSoundPath('assets/long.wav').then((value){
      long = value;
      setState(() {
        loaded++;
        if(isLoaded) print('Clips are loaded');
      });
    });
  }

  get isLoaded{ return loaded >=3; }

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

    return new Column(children: <Widget>[

      new RaisedButton(
        onPressed: () => isLoaded ? player.play(short) : null,
        child: new Text('Play AA')),

      new RaisedButton(
        onPressed: () => isLoaded ? player.play(middle) : null,
        child: new Text('Play AAA')),

      new RaisedButton(
        onPressed: () => isLoaded ? player.play(long) : null,
        child: new Text('Play AAAA')),

    ]);

  }


}