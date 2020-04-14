import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/logic/auth/registerAccount.dart';

class RegisterAccount extends StatefulWidget {
  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  String emailId, pass, pass1;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email Id"
                          ),
                          onSaved: (String val){
                            setState(() {
                              emailId = val.toLowerCase().trim();
                            });
                          },
                          validator: (String val){
                            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val.toLowerCase().trim())){
                              return "Enter a valid email address!";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Create a password"
                          ),
                          validator: (String val){
                            if(val.length < 6){
                              return "Password should be of atleast 6 charecters!";
                            }
                            if(val != pass1){
                              return "Password Mismatch!";
                            }
                            return null;
                          },
                          onSaved: (String val){
                            setState(() {
                              pass = val;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Create a password"
                          ),
                          validator: (String val){
                            if(val.length < 6){
                              return "Password should be of atleast 6 charecters!";
                            }
                            if(val != pass){
                              return "Password Mismatch!";
                            }
                            return null;
                          },
                          onSaved: (String val){
                            setState(() {
                              pass1 = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: (){
                            formKey.currentState.save();
                            if(formKey.currentState.validate()){
                              CreateANewAccount().createAccount(context, emailId, pass);
                            }
                            
                          },
                          child: Text("Register")
                        )
                      ],
                    ),
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