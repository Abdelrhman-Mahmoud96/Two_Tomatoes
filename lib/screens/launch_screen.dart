import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:two_tomatos/design/tomato_colors.dart';
import 'package:two_tomatos/main.dart';
import 'package:two_tomatos/screens/home_screen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  bool _connection ;
  ConnectivityResult _connectionStatus;
  Future _futureConnection;


  @override
    void initState() {
      _connection = false;
      _futureConnection = initConnectivity();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: _futureConnection,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              print('launch');
              return HomeScreen(_connection);
            }
            else if (snapshot.hasError){
              print('something wrong with connection data');
            }

          }
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    TomatoColors.tomatoBlack)),
          );
        },
      ),
    );

    //   SplashScreen(
    //   seconds: 1,
    //    navigateAfterSeconds: HomeScreen(true),
    //   // navigateAfterFuture: _futureConnection,
    //   // image: Image.asset('assets/splash_icon.png'),
    //   photoSize: 50,
    //   // backgroundColor: Color(0xff1b1717),
    //
    // );
  }

  Future<bool> initConnectivity() async {
    ConnectivityResult connectionStatus;
    try {
        connectionStatus = await Connectivity().checkConnectivity();
        if (_connectionStatus == ConnectivityResult.mobile ||  connectionStatus == ConnectivityResult.wifi) {
          _connection = true;
        }
    }
    catch (error) {
      print(error.toString());
    }
    return _connection;
  }




}






