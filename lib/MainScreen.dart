import 'package:flutter/material.dart';
import 'package:flutter_soundboard/SoundPlayer.dart';
import 'package:flutter_soundboard/SoundStorage.dart';

class MainScreen extends StatefulWidget{

  State<StatefulWidget> createState() => new MainScreenState();

}

class MainScreenState extends State<StatefulWidget>{

  SoundPlayer player;

  List<String> soundFilePath;

  @override
  void initState() {
    super.initState();
    player = new SoundPlayer();
  }

  Widget getFuture(){
    return new FutureBuilder<List<String>>(
      future: new SoundStorage().loadSounds(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else{
              soundFilePath = snapshot.requireData;
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

    final space = Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0));

    return new Column(children: <Widget>[
      space,
      new FlatButton(
              onPressed: () => player.play(soundFilePath[0]),
              child: new Image(image: new AssetImage('assets/images/short.png'))
      ),
      space,
      new FlatButton(
              onPressed: () => player.play(soundFilePath[1]),
              child: new Image(image: new AssetImage('assets/images/middle.png'))
      ),
      space,
      new FlatButton(
              onPressed: () => player.play(soundFilePath[2]),
              child: new Image(image: new AssetImage('assets/images/long.png'))
      )

    ]);

  }


}