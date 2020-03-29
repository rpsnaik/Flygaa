import 'package:flutter/material.dart';
import 'package:flygaa_app/views/auth-ui/phoneNumberSignIn.dart';

class AuthUIPage extends StatefulWidget {
  @override
  _AuthUIPageState createState() => _AuthUIPageState();
}

class _AuthUIPageState extends State<AuthUIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to Flygaa"),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhonNumberSignInPage()));
              },
              child: Text("Phone Number SignIn"),
            ),
            // RaisedButton(
            //   onPressed: (){  
            //     GoogleAuth().signInwithGoogle(context);
            //   },
            //   child: Text("Sign in with Google")
            // )
          ],
        )
      )
    );
  }
}

