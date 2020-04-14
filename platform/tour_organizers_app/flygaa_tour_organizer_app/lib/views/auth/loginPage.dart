import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/logic/auth/loginLogic.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, pass;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    onSaved: (String emailId){
                      setState(() {
                        email = emailId;
                      });
                    },
                    validator: (String val){
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val.toLowerCase().trim())){
                        return "Enter a valid email address!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email Id"
                    ),
                  ),
                  TextFormField(
                    onSaved: (String val){
                      setState(() {
                        pass = val;
                      });
                    },
                    validator: (String val){
                      if(val.length < 6){
                        return "Password should be of atleast 6 charecters!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: (){
                      if(formKey.currentState.validate()){
                        formKey.currentState.save();
                        LoginLogic().logInWithEmailAndPass(context, email, pass);
                      }
                    },
                    child: Text("Log in"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}