import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CommonFunctionalities{
  Future<String> uploadtoStorageTask(String path, File file)async{
    String profileImageUrl;
    StorageReference storageReference = FirebaseStorage.instance.ref().child(path);
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    await storageUploadTask.onComplete;

    storageReference.getDownloadURL().then((var downloadUrl){
      print(downloadUrl);
      profileImageUrl = downloadUrl;
    }).catchError((e){
      print(e);
    });

    return profileImageUrl;

  }
}