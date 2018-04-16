import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_soundboard/ISoundPlayer.dart';
import 'package:flutter_soundboard/SoundPlayer.dart';
import 'package:flutter_soundboard/SoundStorage.dart';

class MainScreen extends StatefulWidget{

  State<StatefulWidget> createState() => new MainScreenState();

}

class MainScreenState extends State<StatefulWidget>{



  final soundAssetPath = <String>[
    'assets/sounds/short.wav',
    'assets/sounds/middle.wav',
    'assets/sounds/long.wav'
  ];
  List<String> soundFilePath;

  ISoundPlayer player;
  SoundStorage storage;

  Future _loadSound() async{
    return await Future.forEach(soundAssetPath, (assetPath) async {
      final filePath = await storage.getSoundPath(assetPath);
      soundFilePath.add(filePath);
      print('Sound $filePath added');
    });
  }

  @override
  void initState() {
    super.initState();
    soundFilePath = new List<String>();
    player = new SoundPlayer();

    storage = new SoundStorage();
  }

  Widget getBox(){
    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/short.png'),
        ),
      ),
    );
  }

  Widget getFuture(){
    return new FutureBuilder(
      future: _loadSound(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else{
              print('Loading completed. ${soundFilePath.length} sounds loaded');
              return getLoadedBody();
            }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Soundboard'), leading: new Icon(Icons.hearing)),
      body: getFuture()
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  Widget getLoadedBody(){

    return new Column(children: <Widget>[

      new FlatButton(
              onPressed: () => player.play(soundFilePath[0]),
              child: new Image(image: new AssetImage('assets/images/short.png'))
      ),
      new FlatButton(
              onPressed: () => player.play(soundFilePath[1]),
              child: new Image(image: new AssetImage('assets/images/middle.png'))
      ),
      new FlatButton(
              onPressed: () => player.play(soundFilePath[2]),
              child: new Image(image: new AssetImage('assets/images/long.png'))
      )

    ]);

  }


}