import 'package:assignmentvideo/Providers/AuthProvider.dart';
import 'package:assignmentvideo/Providers/imageProvider.dart';
import 'package:assignmentvideo/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Routes/routes.dart';
import 'Routes/routesName.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  Authprovider()),
        ChangeNotifierProvider(create: (_) =>  ImageProviderClass()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // set to false to remove debug banner
        initialRoute:  RoutesName.homesScreen,
        onGenerateRoute: Routes.generateRoute,
      ),

    );
  }
}

