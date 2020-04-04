// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flygaa_app/logic/auth/googleAuth.dart';

// class GovernmentIdModel{
//   String idIssuedCountry;
//   String idType;
//   String idFrontSidePic;
//   String idBackSidePic;

//   GovernmentIdModel({@required this.idIssuedCountry, @required this.idType, @required this.idFrontSidePic, @required this.idBackSidePic});
// }

// class EmergencyContact{
//   String legalName;
//   String relationShip;
//   String phoneNumber;
//   String languagePreferred;

//   EmergencyContact({@required this.legalName, @required this.relationShip, @required this.phoneNumber, @required this.languagePreferred});
// }

// // class BookingDataModel{
// //   String bookingId;
// //   Timestamp bookedOn;

// //   BookingDataModel({@required this.bookingId, @required this.bookedOn});
// // }

// class FavirouteDestinationModel{
//   String destinationId;
//   Timestamp savedOn;

//   FavirouteDestinationModel({@required this.destinationId, @required this.savedOn});
// }

// class UserData{
//   String uid;
//   String name;
//   Timestamp dateOfBirth;
//   String phoneNumber;
//   String email;
//   String gender;
//   String userProfileImage;

//   List<GovernmentIdModel> governmentId;
//   List<EmergencyContact> emergencyContact;

//   // List<BookingDataModel> yourTourBookings;
//   // List<BookingDataModel> yourAttractionsBookings;

//   List<FavirouteDestinationModel> favirouteDestinations;

//   UserData({@required this.uid, @required this.name, @required this.dateOfBirth, @required this.email, @required this.gender, @required this.phoneNumber, @required this.userProfileImage, @required this.governmentId, @required this.emergencyContact, @required this.favirouteDestinations});
  

// }

// class LoadUserData{
//   Future<UserData> loadUserData()async{
//     UserData userData;
//     Auth auth = Auth();
//     FirebaseUser userDetails = await auth.getCurrentUserInfo();
//     await Firestore.instance.collection("users").document(userDetails.uid).get().then((DocumentSnapshot snapData){
//       userData = UserData(
//         uid: snapData.data['uid'],
//         name: snapData.data['name'],
//         dateOfBirth: snapData.data['dateOfBirth'],
//         email: snapData.data['email'],
//         userProfileImage: snapData.data['userProfileImage'],
//         gender: snapData.data['gender'],
//         governmentId: snapData.data['governmentId'],
//         emergencyContact: snapData.data['emergencyContact'],
//         favirouteDestinations: snapData.data['favirouteDestinations']
//       );
//     }).catchError((e){
//       print(e);
//     });

//     return userData;
//   }
// }