import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'player.dart';

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

class _PlayerHomePageState extends State<PlayerHomePage> {
  // State Management
  String _playerName;
  String _playerSkillRating;
  String _playerIcon;

  /*
    Gets the player data from the from the API asynchronously
  */
  Future<String> getPlayerData(String playerName, String playerID) async {
    var playerDataURL = 'http://ow-api.com/v1/stats/pc/us/' + playerName + '-' + playerID + '/profile';
    http.Response response = await http.get(
      playerDataURL,
      headers: {
        "Accept": "application/json"
      }
    );

    Map playerMap = jsonDecode(response.body);
    var player = Player.fromJson(playerMap);

    setState(() {
      _playerName = '${player.playerName}';
      _playerSkillRating = '${player.skillRating}';
      _playerIcon = '${player.icon}';
    });
  }

  final TextEditingController playerSearchController = new TextEditingController();
  String playerNameResult = "";
  String playerIdResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Tab(
                        icon: new Image.asset('assets/images/overwatch-icon.png', height: 30),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text('STATS YOINKER', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 17, color: Color(0xFF515151))),
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 1,
                  child : SizedBox(
                    height: 35,
                    child: new TextField(
                      controller: playerSearchController,
                      style: TextStyle(fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: 'Eg: Calvin#1337',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: -5.0, horizontal: 15.0),
                        suffixIcon: Icon(Icons.search, color: Color(0xFF515151), size: 20),
                        enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(60.0)), borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(60.0)), borderSide: BorderSide(color: Color(0xFFFA9C1D))),
                      ),
                      onSubmitted: (String str) {
                        setState(() {
                          bool hashDetected = false;

                          // Set to empty
                          playerNameResult = "";
                          playerIdResult = "";

                          for(int i = 0; i < str.length; i++) {
                            if(str[i] == "#") {
                              i++;
                              hashDetected = true;
                            }

                            if(!hashDetected) {
                              playerNameResult += str[i];
                            } else {
                              playerIdResult += str[i];
                            }
                          }
                        });

                        getPlayerData(playerNameResult, playerIdResult);
                      }
                    )
                  )
                )
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network('$_playerIcon', height: 65, width: 65),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('$_playerName', style: TextStyle(fontSize: 15)),
                )
              ],
            )
          )
        ]
      )
    );
  }
}
