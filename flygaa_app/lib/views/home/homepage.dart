import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/temporaryDataAdder/setData.dart';
import 'package:flygaa_app/model/userDataModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  UserData userData;
  LoadUserData loadUserData = LoadUserData();

  void loadingUserInfo()async{
    setState(() {
      isLoading = true;
    });
    userData = await loadUserData.loadUserData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadingUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      drawer: Drawer(

      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[

            // Basic User Details
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Hi, "+userData.name+"!", style: TextStyle(
                    fontSize: 33.0,
                    fontFamily: "Nunito Sans Bold",
                    fontWeight: FontWeight.w800
                  ),),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 17.0
                      ),
                      children: [
                        TextSpan(text: "Where would you like ", style: TextStyle(
                          color: Colors.black
                        )),
                        TextSpan(text: "to go ?", style: TextStyle(
                          color: Colors.blueGrey,
                        )),
                        
                      ]
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10.0,
            ),

            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Best Destinantions", style: TextStyle(
                        fontFamily: "Nunito Sans Regular",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("See all", style: TextStyle(
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),

            //TODO :: Best Destinations
            //BestDestinations(),

            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Popular Attractions", style: TextStyle(
                        fontFamily: "Nunito Sans Regular",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("See all", style: TextStyle(
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),

            //TODO :: Popular Attractions

            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Popular Tours", style: TextStyle(
                        fontFamily: "Nunito Sans Regular",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("See all", style: TextStyle(
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),

            //TODO :: Popular Tours


            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Before Attractions Offers", style: TextStyle(
                        fontFamily: "Nunito Sans Regular",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("See all", style: TextStyle(
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),

            //TODO :: Attraction Offers


            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Best Tour Offers", style: TextStyle(
                        fontFamily: "Nunito Sans Regular",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("See all", style: TextStyle(
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),

            //TODO :: Best Tour Offers



          ],
        ),
      )
    );
  }
}