import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/auth/accountFun.dart';
import 'package:flygaa_app/main.dart';
import 'package:image_picker/image_picker.dart';

class GetBasicInfo extends StatefulWidget {
  final FirebaseUser user;
  GetBasicInfo({@required this.user});
  @override
  _GetBasicInfoState createState() => _GetBasicInfoState();
}

class _GetBasicInfoState extends State<GetBasicInfo> {
  File image;
  bool isUploading = false;
  bool showCheckMark = false;

  bool isSavingData = false;
  
  final editDetailsKey = GlobalKey<FormState>();
  

  String profileImageUrl;
  String name;
  Timestamp dateOfBirth;
  String phoneNumber;
  String emailId;
  String gender;


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Thanks for creating your account!", style: TextStyle(
                    fontFamily: "Nunito Sans Bold",
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0
                  ),),
                  Text("Please fill your Details"),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        FocusScope.of(context).unfocus();

                        

                        void loadImage(ImageSource imageSource)async{
                          image = await ImagePicker.pickImage(
                            source: imageSource,
                            imageQuality: 30
                          );
                          Navigator.pop(context);
                          setState(() {
                            showCheckMark = false;
                            isUploading = false;
                          });
                        }

                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Choose an option"),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Wrap(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          loadImage(ImageSource.gallery);
                                        },
                                        child: Container(
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.photo),
                                              Text("Gallery")
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          loadImage(ImageSource.camera);
                                        },
                                        child: Container(
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.camera),
                                              Text("Camera")
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        );

                        
                      },
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: image != null ? FileImage(image) : null,
                        child: image == null ? Center(
                          child: Icon(Icons.add_a_photo),
                        ) : null,
                      ),
                    )
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: image == null ? Text("Tap to add your Avatar!") : isUploading ? CircularProgressIndicator() : showCheckMark ? Icon(Icons.check, color: Colors.blue,) : RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: ()async{
                        setState(() {
                          isUploading = true;
                          showCheckMark = false;
                        });

                        StorageReference storageReference = FirebaseStorage.instance.ref().child("profileImages/"+widget.user.uid);
                        StorageUploadTask storageUploadTask = storageReference.putFile(image);

                        await storageUploadTask.onComplete;

                        storageReference.getDownloadURL().then((var downloadUrl){
                          profileImageUrl = downloadUrl;
                          setState(() {
                            showCheckMark = true;
                            isUploading = false;
                          });
                          print(profileImageUrl);
                        }).catchError((e){
                          print(e);
                        });
                        
                        // await CommonFunctionalities().uploadtoStorageTask("profileImages/"+widget.user.uid, image).then((String url){
                        //   profileImageUrl = url;
                        //   print("Url : "+url);
                        //   showCheckMark = true;
                        //   isUploading = false;
                        // }).catchError((e){
                        //   print(e);
                        // });
                        //print("Image Url : "+profileImageUrl);
                        setState(() {
                          
                        });
                      },
                      child: Text("Set Image"),
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Personal Details", style: TextStyle(
                          fontFamily: "Nunito Sans Bold",
                          fontSize: 20.0
                        ),),
                        Form(
                          key: editDetailsKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                onSaved: (String nameVal){
                                  setState(() {
                                    name = nameVal;
                                  });
                                },
                                validator: (String nameVal){
                                  if(nameVal.length < 3){
                                    return "Enter valid name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black
                                    )
                                  )
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              
                              Text("Select your Date of Birth", style: TextStyle(
                                fontFamily: "Nunito Sans Bold"
                              ),),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                onTap: ()async{
                                  FocusScope.of(context).unfocus();
                                  dateOfBirth = Timestamp.fromDate(await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1999),
                                    initialDatePickerMode: DatePickerMode.day,
                                    firstDate: DateTime(1910),
                                    lastDate: DateTime.now(),
                                    
                                    builder: (context, i){
                                      return i;
                                    }
                                  ));
                                  setState(() {
                                    
                                  });
                                },
                                child: dateOfBirth == null ? Text("Click to select Date of Birth") : Text(dateOfBirth.toDate().day.toString()+"/"+dateOfBirth.toDate().month.toString()+"/"+dateOfBirth.toDate().year.toString()),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              Text("Select your Gender", style: TextStyle(
                                fontFamily: "Nunito Sans Bold"
                              ),),

                              SizedBox(
                                height: 10.0,
                              ),

                              Container(
                                height: 30.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            gender = "male";
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: gender == "male" ? Colors.cyan : Colors.cyanAccent,
                                            borderRadius: BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1.0,
                                                spreadRadius: 1.0
                                              )
                                            ]
                                          ),
                                          child: Text("Male", style: TextStyle(
                                            fontFamily: "Nunito Sans Bold",
                                            color: gender == "male" ? Colors.white : Colors.black
                                          ),),
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            gender = "female";
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: gender == "female" ? Colors.cyan : Colors.cyanAccent,
                                            borderRadius: BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1.0,
                                                spreadRadius: 1.0
                                              )
                                            ]
                                          ),
                                          child: Text("Female", style: TextStyle(
                                            fontFamily: "Nunito Sans Bold",
                                            color: gender == "female" ? Colors.white : Colors.black
                                          ),),
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            gender = "nonbinary";
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: gender == "nonbinary" ? Colors.cyan : Colors.cyanAccent,
                                            borderRadius: BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1.0,
                                                spreadRadius: 1.0
                                              )
                                            ]
                                          ),
                                          child: Text("Non Binary", style: TextStyle(
                                            fontFamily: "Nunito Sans Bold",
                                            color: gender == "nonbinary" ? Colors.white : Colors.black
                                          ),),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                              ),

                              TextFormField(
                                onSaved: (String emailVal){
                                  setState(() {
                                    emailId = emailVal.trim();
                                  });
                                },
                                validator: (String emailVal){
                                  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailVal)){
                                    return "Enter valid Email Id";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Email ID",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black
                                    )
                                  )
                                ),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              TextFormField(
                                initialValue: widget.user.phoneNumber,
                                enabled: false,
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                                decoration: InputDecoration(
                                  
                                  labelText: "Phone Number",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black
                                    )
                                  )
                                ),
                              ),
                              

                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  isSavingData ? Center(
                    child: CircularProgressIndicator(),
                  ) : Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      color: Colors.cyan,
                      onPressed: ()async{
                        if(editDetailsKey.currentState.validate()){
                          editDetailsKey.currentState.save();
                          setState(() {
                            isSavingData = true;
                          });
                          String issue;
                          if(gender==null){
                            issue = "Please choose your Gender!";
                          }
                          if(dateOfBirth == null){
                            issue = "Please select your Date of birth";
                          }
                          if(gender==null || dateOfBirth == null){
                            issue = "Please select your date of birth and gender";
                          }
                          if(gender==null || dateOfBirth == null){
                            showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text(issue),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"),
                                    )
                                  ],
                                );
                              }
                            );
                          }else{
                            FirebaseUser userData = widget.user;
                            UserUpdateInfo updateInfo = UserUpdateInfo();

                            updateInfo.photoUrl = profileImageUrl;
                            updateInfo.displayName = name;

                            await userData.updateProfile(updateInfo);
                            
                            await userData.updateEmail(emailId);

                            await userData.reload();
                            
                            AccountFun().setUserDataOnFirestore(userData, name, emailId, profileImageUrl, gender, dateOfBirth).then((bool res)async{
                              if(res){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                              }
                            }).catchError((e){
                              print(e);
                            });
                            setState(() {
                              isSavingData = false;
                            });
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Save", style: TextStyle(
                            fontFamily: "Nunito Sans Bold",
                            color: Colors.white,
                            fontSize: 16.0
                          ),)
                        ],
                      )
                    ),
                  ),

                  // Center(
                  //   child: RaisedButton(
                  //     onPressed: ()async{
                  //       await FirebaseAuth.instance.signOut();
                  //     },
                  //     child: Text("Signout"),
                  //   ),
                  // )



                ],
              ),
            )
          ],
        ),
      )
    );
  }
}