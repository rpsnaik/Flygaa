import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/views/auth-ui/authUIPage.dart';
import 'package:flygaa_app/views/home/homepage.dart';
import 'package:flygaa_app/views/profile/getBasicInfoPage.dart';

class AccountFun{

  void accountStatusVerifier(BuildContext context)async{
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user)async{
      if(user == null){
        // Redirect to Sign In Page
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthUIPage()));
      }else{
        checkBeforeGngtoHomePage(context, user);
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<DocumentSnapshot> firestoreAccountVerifier(FirebaseUser userRef)async{
    DocumentSnapshot docData;
    await Firestore.instance.collection("users").document(userRef.uid).get().then((DocumentSnapshot snapData){
      if(snapData.exists){
        docData = snapData;
      }
    }).catchError((e){
      print(e);
    });

    return docData;
  }

  void checkBeforeGngtoHomePage(BuildContext context, FirebaseUser user)async{
    DocumentSnapshot userDoc = await firestoreAccountVerifier(user);
    if(userDoc != null){
      // Redirect to HomePage
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(userData: userDoc,)));
    }else{
      //Set User Details in Firestore and Redirect to HomePage
      // setUserDataOnFirestore(user).then((bool dataSetFlagRef){
      //   checkFlag = dataSetFlagRef;
      // }).catchError((e){
      //   print(e);
      // });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GetBasicInfo(user: user,)));
    }
  }

  Future<bool> setUserDataOnFirestore(FirebaseUser user, String name, String emailId, String picUrl, String gender, Timestamp dob)async{
    bool isDataSet = false;


    await Firestore.instance.collection("users").document(user.uid).setData({
      
      "uid": user.uid,
      "name": name,
      "dateOfBirth": dob,
      "phoneNumber": user.phoneNumber,
      "emailId": emailId,
      "gender": gender,
      "userProfileImage": picUrl,

      "governmentId": null,
      "emergencyContact": null,
      "yourBookings": null,
      "favirouteDestinations": null

    }).then((E){
      isDataSet = true;
    }).catchError((e){
      print(e);
    });

    return isDataSet;
  }

}
