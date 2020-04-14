import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_tour_organizer_app/main.dart';
import 'package:flygaa_tour_organizer_app/templates/errorAlertBox/alertBox.dart';
import 'package:flygaa_tour_organizer_app/views/home/home.dart';

class FillAdditionalDetailsClass{

  void fillAddDetails(BuildContext context, String uid, String emailId, legalName, List<String> locations, String logoUrl, List<String> phoneNumbers, String aboutDetails)async{
    await Firestore.instance.collection("serviceAgentsDetails").document(uid).setData({
      "uid": uid,
      "emailId": emailId,
      "legalName": legalName,
      "locationOfOffices": locations,
      "logoUrl": logoUrl,
      "contactNumbers": phoneNumbers,
      "aboutService": aboutDetails
    }).then((E){
      print("Details updated successfully!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
    }).catchError((e){
      print(e);
      ShowAlertBox().customAlert(context, "Error", e.message);
    });
  }

}