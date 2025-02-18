import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/auth/mobileAuth.dart';

class PhonNumberSignInPage extends StatefulWidget {
  @override
  _PhonNumberSignInPageState createState() => _PhonNumberSignInPageState();
}

class _PhonNumberSignInPageState extends State<PhonNumberSignInPage> {
  final PageController pageController = PageController();

  CountryCode phoneNumberCountry= CountryCode.fromCode("IN");

  bool resendButtonEnabled = true;


  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  // Scaffold.of(context).showSnackBar(snackBar);


  final TextEditingController phoneNumberController = TextEditingController();
  String verificationId;
  
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authCredential) {
      MobileAuth().signInWithCredential(context, authCredential);
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print(authException);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      setState(() {
        resendButtonEnabled = false;
      });
      print("code sent to " + phoneNumberCountry.dialCode + phoneNumberController.text);
      pageController.nextPage(
        duration: Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeIn
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

     await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberCountry.dialCode+phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );

    Future.delayed(Duration(
      seconds: 60
    ), (){
      setState(() {
        resendButtonEnabled = true;
      });
    });

  }


  void _signInWithPhoneNumber(String smsCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode
    );
    MobileAuth().signInWithCredential(context, authCredential);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: pageController,
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CountryCodePicker(
                        
                        searchDecoration: InputDecoration(
                          labelText: "Search for your Country Code !",
                        ),
                        
                        onChanged: (CountryCode countryCode){
                          setState(() {
                            phoneNumberCountry = countryCode;
                          });
                          // print(countryCode.code);
                          //print(countryCode.dialCode);
                        },
                        initialSelection: "IN",
                        
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            labelText: "Enter your Phone Number",
                            prefix: Text(phoneNumberCountry.dialCode)
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: ()async{
                          _sendCodeToPhoneNumber();
                          // await MobileAuth().sendVerificationCode(phoneNumberCountry.dialCode+phoneNumberController.text).then((String verificationId){
                          //   print(verificationId);
                          // }).catchError((e){
                          //   print(e);
                          // });
                          //MobileAuth().verifyMobileNumber(context, pageController, phoneNumberCountry.dialCode+phoneNumberController.text);
                        },
                        child: Text("Get OTP"),
                      ),
                    )
                  ],
                ),
              ),
            ),


            // OTP Page
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Enter the OTP"),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        getPinField(key: "1", focusNode: focusNode1),
                        SizedBox(width: 5.0),
                        getPinField(key: "2", focusNode: focusNode2),
                        SizedBox(width: 5.0),
                        getPinField(key: "3", focusNode: focusNode3),
                        SizedBox(width: 5.0),
                        getPinField(key: "4", focusNode: focusNode4),
                        SizedBox(width: 5.0),
                        getPinField(key: "5", focusNode: focusNode5),
                        SizedBox(width: 5.0),
                        getPinField(key: "6", focusNode: focusNode6),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      //MobileAuth().manualVerifyOfPhoneNumber(context, code);
                      _signInWithPhoneNumber(code);
                    },
                    child: Text("Verify and Login"),
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: (){
                        resendButtonEnabled ? _sendCodeToPhoneNumber() : print("Wait until for 60 seconds!");
                      },
                      child: Text("Resend the Verification Code"),
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



  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
    height: 40.0,
    width: 35.0,
    child: TextField(
      key: Key(key),
      expands: false,
      autofocus: key.contains("1") ? true : false,
      focusNode: focusNode,
      onChanged: (String value) {
        if (value.length == 1) {
          code += value;
          switch (code.length) {
            case 1:
              FocusScope.of(context).requestFocus(focusNode2);
              break;
            case 2:
              FocusScope.of(context).requestFocus(focusNode3);
              break;
            case 3:
              FocusScope.of(context).requestFocus(focusNode4);
              break;
            case 4:
              FocusScope.of(context).requestFocus(focusNode5);
              break;
            case 5:
              FocusScope.of(context).requestFocus(focusNode6);
              break;
            default:
              FocusScope.of(context).requestFocus(FocusNode());
              break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
//          decoration: InputDecoration(
//              contentPadding: const EdgeInsets.only(
//                  bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
//              focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide:
//                      BorderSide(color: Colors.blueAccent, width: 2.25)),
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide: BorderSide(color: Colors.white))),
        ),
  );
}