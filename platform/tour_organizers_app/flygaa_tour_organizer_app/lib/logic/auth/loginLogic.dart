import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flygaa_tour_organizer_app/main.dart';
import 'package:flygaa_tour_organizer_app/templates/errorAlertBox/alertBox.dart';
import 'package:flygaa_tour_organizer_app/views/home/home.dart';

class LoginLogic{
  void logInWithEmailAndPass(BuildContext context, String email, String pass)async{

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((AuthResult res)async{
      print("Signed in As : " +res.user.uid);
      if(!res.user.isEmailVerified){
        await showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Verify email address"),
              content: Text("We have sent you an email to verify your email id - click on the link sent to your inbox!"),
              actions: <Widget>[
                FlatButton(
                  onPressed: ()async{
                    await res.user.sendEmailVerification().then((E){
                      Navigator.pop(context);
                      ShowAlertBox().customAlert(context, "Email sent successfully!", "");
                    }).catchError((e){
                      ShowAlertBox().customAlert(context, "Error", e.message);
                    });
                  },
                  child: Text("Resend email for verification!"),
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Okay"),
                ),
              ],
            );
          }
        );
      }else{
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
      }
    }).catchError((e){
      ShowAlertBox().customAlert(context, "Error", e.message);
    });
  } 
}