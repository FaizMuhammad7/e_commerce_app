import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../helpers/permission_handler.dart';


class UploadImageController extends GetxController {
  var percentage = 0.0.obs;
  var imageUrl = "".obs;

  Future<String> uploadImage(Reference ref, String filepath) async {
    var extension = filepath.split('.').last;
    var fileName = filepath.split('/').last;
    UploadTask uploadTask = ref.child(fileName).putData(
      File(filepath).readAsBytesSync(),
      SettableMetadata(
        contentType: allMimeTypesMap[extension],
      ),
    );

    /// Progress ko listen karny ka ley ur progress ko dkh ny ka ley
    uploadTask.snapshotEvents.listen((snapshot) {
      percentage.value = snapshot.bytesTransferred / snapshot.totalBytes;
      print(percentage);
    });

    TaskSnapshot taskSnapshot = await uploadTask;
    var imageUrl = taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
