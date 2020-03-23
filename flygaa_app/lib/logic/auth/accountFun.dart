import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/views/auth-ui/authUIPage.dart';
import 'package:flygaa_app/views/home/homepage.dart';
import 'package:flygaa_app/views/somethingWentWrong/somethingWentWrongPage.dart';

class AccountFun{

  void accountStatusVerifier(BuildContext context)async{
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user)async{
      if(user == null){
        // Redirect to Sign In Page
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthUIPage()));
      }else{
        checkBeforeGngtoHomePage(user).then((bool redirectFlag){
          if(redirectFlag){
            // Redirect To HomePage
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }else{
            // Something went wrong page
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SomethingWentWrongPage()));
          }
        }).catchError((e){
          print(e);
        });
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<bool> firestoreAccountVerifier(FirebaseUser userRef)async{
    bool accountFlag = false;
    await Firestore.instance.collection("users").document(userRef.uid).get().then((DocumentSnapshot snapData){
      if(snapData.exists){
        accountFlag = true;
      }
    }).catchError((e){
      print(e);
    });

    return accountFlag;
  }

  Future<bool> checkBeforeGngtoHomePage(FirebaseUser user)async{
    bool checkFlag = false;
    if(await firestoreAccountVerifier(user)){
      // Redirect to HomePage
      checkFlag = true;
    }else{
      //Set User Details in Firestore and Redirect to HomePage
      setUserDataOnFirestore(user).then((bool dataSetFlagRef){
        checkFlag = dataSetFlagRef;
      }).catchError((e){
        print(e);
      });
    }

    return checkFlag;
  }

  Future<bool> setUserDataOnFirestore(FirebaseUser user)async{
    bool isDataSet = false;
    await Firestore.instance.collection("users").document(user.uid).setData({
      
      "uid": user.uid,
      "name": user.displayName,
      "dateOfBirth": null,
      "phoneNumber": user.phoneNumber,
      "emailId": user.email,
      "gender": null,
      "userProfileImage": user.photoUrl,

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
