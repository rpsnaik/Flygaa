import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/auth/accountFun.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Flygaa Application",
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Nunito Sans Regular',
      ),
    )
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed((Duration(seconds: 1)), (){
      AccountFun().accountStatusVerifier(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("./assets/images/mainLogo.png", height: 250.0,),
      ),
    );
  }
}