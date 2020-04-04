import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flygaa_app/main.dart';
import 'package:flygaa_app/ui-components/travelTips.dart';
import 'package:flygaa_app/views/home/bestDestinations.dart';

class HomePage extends StatefulWidget {
  final DocumentSnapshot userData;
  HomePage({@required this.userData});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currTabIndex = 0;
  final bodyPageView = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Colors.cyan
        ),
        
        currentIndex: currTabIndex,
        onTap: (int index){
          
          bodyPageView.animateToPage(index, duration: Duration(
            milliseconds: 500
          ), curve: Curves.easeInOut);
          setState(() {
            currTabIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home", style: TextStyle(
              color: Colors.cyan,
              fontFamily: "Nunito Sans Bold"
            ),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            title: Text("Tours", style: TextStyle(
              color: Colors.cyan,
              fontFamily: "Nunito Sans Bold"
            ),)
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      drawer:  Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: widget.userData.data['userProfileImage'] == null ? Image(
                  image: AssetImage("./assets/images/mainLogo.png"),
                ) : Image(
                  image: NetworkImage(widget.userData.data['userProfileImage']),
                ),
                accountEmail: Text(widget.userData.data['emailId'], style: TextStyle(
                  fontFamily: "Nunito Sans Bold"
                ),),
                accountName: Text(widget.userData.data['name'], style: TextStyle(
                  fontFamily: "Nunito Sans Bold",
                  fontSize: 18.0
                ),),
              ),
              
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Home"),
                    ),
                    InkWell(
                      onTap: ()async{
                        await FirebaseAuth.instance.signOut().then((E){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context)=>SplashScreen()
                          ), (Route<dynamic> r) => false);
                        }).catchError((e){
                          print(e);
                        });
                      },
                      child: ListTile(
                        title: Text("Sign out"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset("./assets/images/mainLogo.png", width: 65.0,),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          )
        ],
      ),
      body: PageView(
        controller: bodyPageView,
        physics: NeverScrollableScrollPhysics(),
        // onPageChanged: (int i){
        //   setState(() {
        //     currTabIndex = i;
        //   });
        // },
        children: <Widget>[

          //HomePage
          Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[

                // Basic User Details
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hi, "+widget.userData.data['name']+"!", style: TextStyle(
                            fontSize: 33.0,
                            fontFamily: "Nunito Sans Bold",
                            fontWeight: FontWeight.w900
                          ),),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: "Nunito Sans Bold",
                                fontSize: 17.0
                              ),
                              children: [
                                TextSpan(text: "Where will you go ", style: TextStyle(
                                  color: Colors.black
                                )),
                                TextSpan(text: "today ?", style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w900
                                )),
                                
                              ]
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: widget.userData.data['userProfileImage'] == null ? AssetImage('./assets/images/mainLogo.png') : NetworkImage(widget.userData.data['userProfileImage']),
                      )
                    ],
                  )
                ),

                SizedBox(
                  height: 10.0,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
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
                BestDestinations(),

                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("./assets/images/mountains.jpg"),
                      fit: BoxFit.cover,
                      //colorFilter: ColorFilter.linearToSrgbGamma()
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight)
                    ),
                    
                  ),
                  child: Text("Get to know about New Places", textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Inter",
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset.fromDirection(40.0)
                      )
                    ]
                  ),),
                ),

                SizedBox(
                  height: 10.0,
                ),

                // Travel Tips

                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Travel Tips", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TravelTips(
                              onTap: (){
                                // Restaurants
                              },
                              title: "Restaurant",
                            )
                          ),
                          Expanded(
                            child: TravelTips(
                              onTap: (){
                                // Traffic
                              },
                              title: "Traffic",
                            )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TravelTips(
                              onTap: (){
                                // Sightseeing
                              },
                              title: "Sightseeing",
                            )
                          ),
                          Expanded(
                            child: TravelTips(
                              onTap: (){
                                // Hotel
                              },
                              title: "Hotel",
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                

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
          ),


          //TODO : Trips Page
          Center(
            child: Text("trips"),
          )
        ],
      )
    );
  }
}