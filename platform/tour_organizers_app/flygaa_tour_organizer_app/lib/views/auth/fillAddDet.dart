import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flygaa_tour_organizer_app/logic/auth/fillAdditionalDet.dart';
import 'package:flygaa_tour_organizer_app/templates/errorAlertBox/alertBox.dart';
import 'package:image_picker/image_picker.dart';

class FillAdditionalDetailsPage extends StatefulWidget {
  final FirebaseUser user;
  FillAdditionalDetailsPage({@required this.user});
  @override
  _FillAdditionalDetailsPageState createState() => _FillAdditionalDetailsPageState();
}

class _FillAdditionalDetailsPageState extends State<FillAdditionalDetailsPage> {
  final formKey = GlobalKey<FormState>();
  String name, about, profileImgUrl;

  List<String> loactions = [];
  List<String> phoneNums = [];

  File imageFile;

  FirebaseStorage _storage = FirebaseStorage.instance;
  ImageSource imageSource;

  bool isUploading = false;
  bool isNewImageSel = false;

  void uploadProfilePic()async{
    setState(() {
      isUploading = true;
    });
    StorageReference storageReference = _storage.ref().child("serviceAgentsProfilePics/"+widget.user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete.then((StorageTaskSnapshot snapData)async{
      profileImgUrl = await storageReference.getDownloadURL();
      setState(() {
        isNewImageSel = false;
        isUploading = false;
      });
    }).catchError((e){
      print(e);
      ShowAlertBox().customAlert(context, "Error", e.message);
    });
  }

  void selectTheMode()async{
    
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Choose an option"),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    imageSource = ImageSource.camera;
                    ImagePicker.pickImage(
                      imageQuality: 10,
                      source: imageSource
                    ).then((File img){
                      setState(() {
                        imageFile = img;
                        isNewImageSel = true;
                      });
                      Navigator.pop(context);
                    });
                  },
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera),
                          Text("Camera")
                        ],
                      ),
                    ],
                  )
                ),
                InkWell(
                  onTap: (){
                    imageSource = ImageSource.gallery;
                    ImagePicker.pickImage(
                      imageQuality: 10,
                      source: imageSource
                    ).then((File img){
                      setState(() {
                        imageFile = img;
                        isNewImageSel = true;
                      });
                      Navigator.pop(context);
                    });
                  },
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.photo_album),
                          Text("Gallery")
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        );
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill Additional Info"),
      ),
      body: ListView(
        primary: true,
        shrinkWrap: true,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            selectTheMode();
                          },
                          child: CircleAvatar(
                            radius: 30.0,
                            child: imageFile == null ? Icon(Icons.person) : Image.file(imageFile)
                          ),
                        )
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: isUploading ? CircularProgressIndicator() : isNewImageSel ? RaisedButton(
                          onPressed: ()async{
                            if(imageFile != null){
                              uploadProfilePic();
                            }else{
                              ShowAlertBox().customAlert(context, "Please select an image", "");
                            }
                          },
                          child: Text("Upload"),
                        ) : imageFile == null ? Text("Add your profile pic by tapping over above!") : Icon(Icons.check),
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: widget.user.email,
                        decoration: InputDecoration(
                          labelText: "Email Id"
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Service/Organization Legal Name"
                        ),
                        onSaved: (String val){
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (String val){
                          if(val.length < 4 || val.length >30){
                            return "Enter valid Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Service/Organization Offices Locations", style: TextStyle(
                        color: Colors.grey,
                      ),),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: loactions.length + 1,
                        itemBuilder: (context, i){
                          if(loactions.length == i){
                            return InkWell(
                              onTap: ()async{
                                 await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: "AIzaSyBCzEymZFqVBuvZ7b1Oz6vQTUM7tS91pxo",
                                  mode: Mode.fullscreen,
                                  language: "en",
                                ).then((var p){
                                  if(p != null){
                                    loactions.add(p.description);
                                    setState(() {
                                      
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0
                                    )
                                  ]
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add,),
                                    Text("Add a Organization Branch", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),)
                                  ],
                                ),
                              )
                            );
                          }
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  Text(loactions[i])
                                ],
                              ),
                            )
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Contact Details", style: TextStyle(
                        color: Colors.grey,
                      ),),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: phoneNums.length + 1,
                        itemBuilder: (context, i){
                          if(phoneNums.length == i){
                            return InkWell(
                              onTap: (){
                                TextEditingController textEditingController = TextEditingController();
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text("Enter contact data (Email/ Phone Number)"),
                                      content: TextFormField(
                                        controller: textEditingController,
                                        decoration: InputDecoration(
                                          labelText: "Phone Number/ Email Id",
                                          hintText: "Email id and Password"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        FlatButton(
                                          onPressed: (){
                                            phoneNums.add(textEditingController.text.toString());
                                            Navigator.pop(context);
                                            setState(() {
                                              
                                            });
                                          },
                                          child: Text("Save"),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0
                                    )
                                  ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add),
                                    Text("Add Contact Numbers", style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                ),
                              )
                            );
                          }
                          return Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.phone),
                                Text(phoneNums[i])
                              ],
                            ),
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "About (500 Charecters)"
                        ),
                        maxLength: 500,
                        validator: (String val){
                          if(val.length < 10){
                            return "Please describe about your service!";
                          }
                          return null;
                        },
                        onSaved: (String val){
                          setState(() {
                            about = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            if(loactions.length == 0 || phoneNums.length == 0){
                              ShowAlertBox().customAlert(context, "Error", "Please select branch location or Contact details");
                            }else{
                              FillAdditionalDetailsClass().fillAddDetails(context, widget.user.uid, widget.user.email, name, loactions, profileImgUrl, phoneNums, about);
                            }
                          }
                        },
                        child: Text("Submit"),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}