import 'package:flutter/material.dart';

class ShowAlertBox{
   void customAlert(BuildContext context, String title, String msg)async{
     await showDialog(
       context: context,
       builder: (context){
         return AlertDialog(
           title: Text(title),
           content: Text(msg),
           actions: <Widget>[
             RaisedButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               color: Colors.blue,
               child: Text("Okay"),
             )
           ],
         );
       }
     );
   }
}