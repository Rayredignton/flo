import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo/resources/firebase_methods.dart';
//import 'package:flo/resources/firebase_repository.dart';
import 'package:flo/screens/Home_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMethods _repository = AuthMethods();
  bool isLoginPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
        
          children: <Widget>[Text("Flo", style: TextStyle(color: Colors.teal) ,),
        Text("chat", style: TextStyle(color: Colors.pink)),
        ],
        ),
        elevation: 2.0,
        centerTitle: true,
      ),
             
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget> [

        
          Center(
            child: Container(
                height:300,
                width: 300,
              padding: EdgeInsets.only(bottom: 180),
                child: CircleAvatar(
                  child: ClipOval(
                     child: new FlareActor("assets/teddy_test.flr",
                  
                     alignment: Alignment.center, fit: BoxFit.contain, 
                      animation: "success",),
                  ),
                  backgroundColor: Colors.white,
                )

              ),
          ),
          
          
              Center(
                
        child: loginButton(),
      ),
       if (isLoginPressed) Center(
         
        child:
        
         Padding(
           padding: EdgeInsets.only(top: 80),
                    child: SpinKitFadingFour(
            
                 color: Colors.blue[900],
                   size: 40.0),
         )
       )
       else Container()
        ],
      ),
      
    );
  }

  Widget loginButton(){
    return Shimmer.fromColors(
      
      baseColor: Colors.teal,
      highlightColor: Colors.pink,
          child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text(
          "Tap To Sign In",
          style: TextStyle(
          fontSize: 35,fontWeight: 
          FontWeight.w900, letterSpacing:1.2),

        ),
        color: Colors.transparent,
        onPressed:  ()=> performLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
    );
  }
  void performLogin(){
    setState(() {
      isLoginPressed = true;
    });
    _repository.signIn().then((FirebaseUser user) {
      if (user != null){
        authenticateUser(user);
      }else{
        print("there was an error");
      }
    });
      }
    void authenticateUser(FirebaseUser user){
      _repository.authenticateUser(user).then((isNewUser){
        setState(() {
          isLoginPressed = false;
        });
        if(isNewUser){
          _repository.addDataToDb(user).then((value){
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (ontext){
              return HomeScreen();
            })); 
          });
      }else {
         Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (ontext){
              return HomeScreen();
               }));
      }
    });
  }
}
