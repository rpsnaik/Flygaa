import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/views/auth/register.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Page"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterAccount()));
                },
                child: Text("Register"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Login"),
              )
            ],
          ),
        )
      ),
    );
  }
}
