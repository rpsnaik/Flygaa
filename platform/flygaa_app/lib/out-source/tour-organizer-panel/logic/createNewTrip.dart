import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flygaa_app/out-source/tour-organizer-panel/views/createANewTour.dart';

class AddNewTrip{
  Future<bool> addNewTrip(String tourTagLine, String tourShortTagLine, String tourToDes, String whatWeWillBeDoing, String ppp, String oppp, String tourOfferedByOrg, )async{
    bool flag = false;

    DocumentReference docRef = Firestore.instance.collection("tours").document();
    await docRef.setData({
      "tourId": docRef.documentID,
      
    }).then((E){
      flag = true;
    }).catchError((e){
      print(e);
    });

    return flag;
  }
}