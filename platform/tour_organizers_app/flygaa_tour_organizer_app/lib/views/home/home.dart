import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            child: Text("Home Page"),
          )
        ),
      ),
    );
  }
}