import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assignmentvideo/Routes/routes.dart';
import 'package:assignmentvideo/Routes/routesName.dart';
import 'package:assignmentvideo/Screens/login.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    _startNavigation();
    super.initState();
  }
  void _startNavigation() async {
    await Future.delayed(Duration(milliseconds: 500)); // Adjust the delay as needed
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery
        .of(context)
        .size;

    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("VideoRells",
              style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'cursive',
                  color: Colors.white
              ),),
          ],
        ),
      ),
      nextScreen: Login(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blue,
      duration: 6000,
    );
  }

  void _checkAuthentication() async {

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;
        // Check if the user has required data (name and profile pic) in the database
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection(
            'Users').doc(uid).get();

        if (userData.exists && userData['name'] != null) {
          // User is authenticated and has required data, navigate to the main screen
          Navigator.push(
            context,
            Routes.generateRoute(RouteSettings(name: RoutesName.home)),
          );
        } else {
          // User is authenticated but doesn't have required data, navigate to the details screen
          Navigator.push(
            context,
            Routes.generateRoute(RouteSettings(name: RoutesName.DetailsScreen)),
          );
        }
      } else {
        Navigator.push(
          context,
          Routes.generateRoute(RouteSettings(name: RoutesName.login)),
        );
      }
    }catch(e){

      print(e.toString());

    }

    }
}

