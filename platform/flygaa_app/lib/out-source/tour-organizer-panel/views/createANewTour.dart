import 'dart:core';

import 'package:flutter/material.dart';

class FeaturedPics{
  String featuredImageUrl;
  String featuredTitle;

  FeaturedPics({@required this.featuredTitle, @required this.featuredImageUrl});
}

class CreateANewTour extends StatefulWidget {
  @override
  _CreateANewTourState createState() => _CreateANewTourState();
}

class _CreateANewTourState extends State<CreateANewTour> {
  String tourTagLine;
  String tourShortTagLine;
  String tourToDestination;
  String whatWeWillBeDoing;
  int ppp;
  int oppp;

  String tourOfferedById;

  List<FeaturedPics> featuredPics;

  List<String> categories;

  int durationOfTour;

  List<String> languages;

  String yourGuideId;

  String guideWordsOnThisTrip;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create A New Tour"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        tourTagLine = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Tour Tag Line",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        tourShortTagLine = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Short Tag Line",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        tourToDestination = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Tour to Destination",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        whatWeWillBeDoing = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "What we will be doing ?",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        ppp = data as int;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Price Per Person",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        oppp = data as int;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Offer Price Per Person",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        tourOfferedById = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Tour Offered By Id",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        categories = data.split(",");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Categories",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        durationOfTour = data as int;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Duration of Tour",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        languages = data.split(",");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Languages",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        yourGuideId = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Guide Id",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String data){
                      setState(() {
                        guideWordsOnThisTrip = data;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Guide Words on this trip",
                    ),
                  ),

                  RaisedButton(
                    onPressed: (){
                      
                    },
                    child: Text("Submit"),
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