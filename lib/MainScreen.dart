import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget{

  State<StatefulWidget> createState() => new MainScreenState();

}

class MainScreenState extends State<StatefulWidget>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Soundboard'), leading: new Icon(Icons.hearing)),
      body: getBody(),
    );
  }

  Widget getBody(){
    return new RaisedButton(onPressed: null,child: new Text('Button'));
  }
}