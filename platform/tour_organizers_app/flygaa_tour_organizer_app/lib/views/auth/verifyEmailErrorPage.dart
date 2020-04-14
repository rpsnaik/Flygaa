import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/main.dart';

class VerifyEmailIdPage extends StatefulWidget {
  @override
  _VerifyEmailIdPageState createState() => _VerifyEmailIdPageState();
}

class _VerifyEmailIdPageState extends State<VerifyEmailIdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email Address"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("We had sent you an email to verify your account!"),
            Text("Once you verified your account! Click on "),
            RaisedButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
              },
              child: Text("Click here once you verified your email!"),
            )
          ],
        ),
      ),
    );
  }
}