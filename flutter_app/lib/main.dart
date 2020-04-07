import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';



void main() => runApp(StatsYoinker());

class StatsYoinker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerHomePage(),
    );
  }
}

class PlayerHomePage extends StatefulWidget {
  @override
  _PlayerHomePageState createState() => _PlayerHomePageState();
}

class PlayerHomePageStats {

}

class _PlayerHomePageState extends State<PlayerHomePage> {
  String serverResponse = 'Server response';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Tab(
                          icon: new Image.asset("assets/images/overwatch-icon.png", height: 35),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('STATS YOINKER', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 20, color: Color(0xFF515151))),
                        ),
                      ],
                    ),
                    new Expanded(
                      child: new TextField(
                            decoration: InputDecoration(
                              hintText: 'SEARCH PLAYER',
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.search, color: Color(0xFF515151)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFA9C1D), width: 2.0)),
                            ),
                            onSubmitted: (String value) async {
                              print(value);
                            },
                            style: TextStyle(
                              fontSize: 15.0,
                            )
                      )
                    )
                  ],
                )
              )
            ],
          ),
        ],
      )
    );
  }

  _makeGetRequest() async {
    Response response = await get(_localhost());
    setState(() {
      serverResponse = response.body;
    });
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3000';
    else // for iOS simulator
      return 'http://localhost:3000';
  }

}