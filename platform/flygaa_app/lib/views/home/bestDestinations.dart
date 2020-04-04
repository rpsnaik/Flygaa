import 'package:flutter/material.dart';
import 'package:flygaa_app/logic/homePage/bestDestinationsLoader.dart';
import 'package:flygaa_app/model/HomePage/homePage.dart';

class BestDestinations extends StatefulWidget {
  @override
  _BestDestinationsState createState() => _BestDestinationsState();
}

class _BestDestinationsState extends State<BestDestinations> {

  List<BestDestinationsModel> data = [];
  bool isLoading = false;

  void loadBestDestinationsData()async{
    setState(() {
      isLoading = true;
    });
    data = await BestDestinationsLoader().loadBestDestinations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadBestDestinationsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length+1,
        itemBuilder: (context, i){
          if(i == data.length){
            return InkWell(
              onTap: (){
                
              },
              child: Container(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.52,
                  margin: EdgeInsets.only(left: 20.0, right: 0.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height*0.4,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  child: Icon(Icons.chevron_right),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("See More", style: TextStyle(
                                  fontFamily: "Nunito Bold",
                                  color: Colors.white
                                ),)
                              ],
                            ),
                          )
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 10.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Text(da, style: TextStyle(
                        //         fontFamily: "Nunito Bold",
                        //         fontSize: 18.0
                        //       ),),
                        //       Text(data[i].tagLine)
                        //     ],
                        //   )
                        // )
                      ],
                    )
                  ),
                )
              ),
            );
          }
          return Container(
            width: MediaQuery.of(context).size.width*0.5,
            margin: EdgeInsets.only(left: 20.0, right: 0.0),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(data[i].thumbnail),
            //     fit: BoxFit.cover
            //   )
            // ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data[i].thumbnail),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent
                            ]
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.white, size: 18.0,),
                            Text(data[i].state+", "+data[i].country, style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                    
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data[i].destinationName, style: TextStyle(
                          fontFamily: "Nunito Bold",
                          fontSize: 18.0
                        ),),
                        Text(data[i].tagLine)
                      ],
                    )
                  )
                ],
              )
            )
          );
        },
      )
    );
  }
}