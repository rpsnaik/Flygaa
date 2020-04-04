import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/views/auth/authPage.dart';
import 'package:flygaa_tour_organizer_app/views/home/home.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Flygaa Tour Organizer",
      home: SplashScreen(),
    )
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void onLoadFun()async{
    Future.delayed(Duration(
      seconds: 2
    ), () async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if(user == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthPage()));  
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
      
    });
  }
  @override
  void initState() {
    onLoadFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Flygaa"),
        ),
      ),
    );
  }
}