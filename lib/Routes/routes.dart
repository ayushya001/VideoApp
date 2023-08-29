

import 'package:assignmentvideo/Routes/routesName.dart';
import 'package:assignmentvideo/Screens/Home.dart';
import 'package:assignmentvideo/Screens/SplashScreen.dart';
import 'package:assignmentvideo/Screens/Verify.dart';
import 'package:assignmentvideo/Screens/homes.dart';
import 'package:assignmentvideo/Screens/profileDetails.dart';
import 'package:assignmentvideo/widgets/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/login.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context ) => const Login());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context ) => const HomeScreen());



      case RoutesName.Splashscreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const SplashScreen());

      case RoutesName.DetailsScreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const ProfileDetails());

      case RoutesName.homesScreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const homes());







      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text(
                  "No routes selected"
              ),
            ),
          );
        });
    }
  }
}