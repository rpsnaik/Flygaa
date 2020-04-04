import 'package:flutter/material.dart';

class TourOrganizerPage extends StatefulWidget {
  @override
  _TourOrganizerPageState createState() => _TourOrganizerPageState();
}

class _TourOrganizerPageState extends State<TourOrganizerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Organizer Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){

              },
              child: Text("Create A New Tour"),
            ),
            RaisedButton(
              onPressed: (){

              },
              child: Text("All My Tours"),
            ),
          ],
        ),
      ),
    );
  }
}