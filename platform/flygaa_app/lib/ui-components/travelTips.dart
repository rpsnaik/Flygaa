import 'package:flutter/material.dart';

class TravelTips extends StatefulWidget {
  final String title;
  final Function onTap;
  TravelTips({@required this.title, @required this.onTap});
  @override
  _TravelTipsState createState() => _TravelTipsState();
}

class _TravelTipsState extends State<TravelTips> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.only(left: 10.0),
        child: Container(
            height: 130.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue,
                gradient: LinearGradient(
                    colors: widget.title == "Restaurant" ? [Colors.blueGrey, Colors.blue] : widget.title == "Traffic" ? [Colors.grey, Colors.brown] : widget.title == "Sightseeing" ? [Colors.green, Colors.blue] : [Colors.indigo, Colors.blue], 
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  )
                ),
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: "Nunito Sans Bold"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10.0,
                        child: Icon(
                          Icons.chevron_right,
                          size: 20.0,
                        ),
                      ),
                      Image.asset(
                        "./assets/images/mainLogo.png",
                        width: 40.0,
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
