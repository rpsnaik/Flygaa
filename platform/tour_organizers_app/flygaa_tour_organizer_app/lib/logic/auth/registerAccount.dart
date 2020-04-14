import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/templates/errorAlertBox/alertBox.dart';
import 'package:flygaa_tour_organizer_app/views/auth/fillAddDet.dart';

class CreateANewAccount{
  
  void createAccount(BuildContext context, String emailId, String pass)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailId,
      password: pass
    ).then((AuthResult res)async{
      await res.user.sendEmailVerification();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FillAdditionalDetailsPage(user: res.user,)));
    }).catchError((e){
      ShowAlertBox().customAlert(context, "Error", e.message);
      print(e);
    });
  }

}