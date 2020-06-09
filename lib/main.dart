
//import 'package:flo/screens/Home_screen.dart';
//import 'package:flo/screens/Home_screen.dart';
import 'package:flo/provider/user_provider.dart';
import 'package:flo/resources/firebase_methods.dart';

//import 'package:flo/screens/Home_screen.dart';
//import 'package:flo/screens/Landingscreen.dart';
import 'package:flo/screens/chatscreens/chat_screen.dart';


import 'package:flo/screens/login_screen.dart';
import 'package:flo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import 'models/user.dart';
import 'provider/image_upload_provider.dart';
import 'screens/Home_screen.dart';
import 'screens/Landingscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final AuthMethods _authMethods = AuthMethods();
    
  @override
  Widget build(BuildContext context) {
  return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flo chat',
      initialRoute: '/',
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/search_screen': (context)=> SearchScreen(),
       '/chat_screen': (context) => ChatScreen(),
      },
      theme: ThemeData(
        
        brightness: Brightness.light,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
       // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _authMethods.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
          if(snapshot.hasData){
            return HomeScreen();
          }else{
            return GettingStartedScreen();
          }
        },
      ),
      )
    );
  }
}
class HomeWidget extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authMethods.getUserDetails(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return GettingStartedScreen();
        }
      },
    );
  }
}

