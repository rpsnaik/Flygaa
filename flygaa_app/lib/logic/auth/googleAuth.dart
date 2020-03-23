import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/auth/accountFun.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{

  Future<FirebaseUser> getCurrentUserInfo()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user == null ? print("No User Logged in!") : print("Current User : "+user.uid);
    return user;
  }

  void signOut()async{
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    print("Sign out Successful!");
  }

}

class GoogleAuth{
  Auth auth = Auth();
  Future<FirebaseUser> signInwithGoogle(BuildContext context)async{
    
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    await googleSignIn.signIn().then((GoogleSignInAccount googleSignInAccount)async{

      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      auth.getCurrentUserInfo().then((FirebaseUser user){
        print("Logged in as : "+user.displayName);
        AccountFun().checkBeforeGngtoHomePage(user);
      });
      

    }).catchError((e){
      print(e);
    });
    
    return auth.getCurrentUserInfo();

  }

 


}