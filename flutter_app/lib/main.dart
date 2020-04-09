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
  var _isLoading = true;
  String _playerName;
  String _playerSkillRatingGeneral;
  String _playerIcon;

  /*
    Gets the player data from the from the API asynchronously
  */
  Future<String> getPlayerData(String playerName, String playerID, int playerSkillRatingGeneral) async {
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
      _playerSkillRatingGeneral = '${player.skillRatingGeneral}';
      _playerIcon = '${player.icon}';
    });
  }

  final TextEditingController playerSearchController = new TextEditingController();
  String playerNameResult = "";
  String playerIdResult = "";
  int playerSkillRatingGeneral = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Simple AppBar addition
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/overwatch-icon.png', height: 30,
              fit: BoxFit.contain,
            ),
            Container(
              padding: const EdgeInsets.all(8.0), child: Text('STATS YOINKER', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 17, color: Color(0xFF515151))),
            ),
          ],
        ),
      ),
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
                  ),
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
                          playerSkillRatingGeneral = 0;

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

                        getPlayerData(playerNameResult, playerIdResult, playerSkillRatingGeneral);
                        print("General Skill Rating: "+_playerSkillRatingGeneral);
                        
                        
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(//Profile Icon
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network('$_playerIcon', height: 55, width: 55),
                ),
                Container(//Battletag name container
                  padding: EdgeInsets.only(left: 10),
                  child: Text(playerNameResult + '\n' + '#' + playerIdResult, style: TextStyle(fontSize: 15)),
                  constraints: BoxConstraints.expand(width: 125, height: 50),
                ),
              ],
            ),
          ),
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                  'SELECT YOUR ROLE'
                ),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(//Tank Icon
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset('assets/images/Role_Icons/tank-icon.png', height: 40, width: 40),
                ),
                ClipRRect(//DPS Icon
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset('assets/images/Role_Icons/dps-icon.png', height: 40, width: 40),
                ),
                ClipRRect(//Support Icon
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset('assets/images/Role_Icons/support-icon.png', height: 40, width: 40),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}
