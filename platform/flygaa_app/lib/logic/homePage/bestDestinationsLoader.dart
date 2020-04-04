import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flygaa_app/model/HomePage/homePage.dart';

class BestDestinationsLoader{

  Future<List<BestDestinationsModel>> loadBestDestinations()async{
    List<BestDestinationsModel> bestDestinations = [];
    await Firestore.instance.collection("appDataUIModel").document("destinationData").get().then((DocumentSnapshot dataSnap){
        for(int i=0; i<dataSnap.data['popularDestinations'].length; i++){
          bestDestinations.add(BestDestinationsModel(
            destinationId: dataSnap.data['popularDestinations'][i]['destinationId'],
            destinationName: dataSnap.data['popularDestinations'][i]['destinationName'],
            thumbnail: dataSnap.data['popularDestinations'][i]['thumbnail'],
            state: dataSnap.data['popularDestinations'][i]['state'],
            country: dataSnap.data['popularDestinations'][i]['country'],
            tagLine: dataSnap.data['popularDestinations'][i]['tagLine']
          ));
        }      
    }).catchError((e){
      print(e);
    });

    return bestDestinations;
  }
  
}