import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/views/auth/authPage.dart';
import 'package:flygaa_tour_organizer_app/views/auth/fillAddDet.dart';
import 'package:flygaa_tour_organizer_app/views/auth/verifyEmailErrorPage.dart';
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
    await Future.delayed(Duration(
      seconds: 1
    ), () async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if(user == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthPage()));  
      }else{
        DocumentSnapshot userData = await Firestore.instance.collection("serviceAgentsDetails").document(user.uid).get();
        if(!userData.exists){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FillAdditionalDetailsPage(user: user,)));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }
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