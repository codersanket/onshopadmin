import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as pick;

class SubCategoryController extends GetxController {
  var image = pick.PickedFile("").obs;
  String _uploadedFileURL;
  pick.PickedFile im;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  var loading = false.obs;
  chooseFile() async {
    await pick.ImagePicker.platform
        .pickImage(source: pick.ImageSource.gallery)
        .then((ima) {
      image.value = ima;
    });
  }

  Future<String> uploadFile() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${image.value.path}}');
    UploadTask uploadTask = storageReference.putFile(File(image.value.path));
    await uploadTask.whenComplete(() => print("File Uploaded"));
    await storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
      print(_uploadedFileURL);
    });
    return _uploadedFileURL;
  }

  removeImage() {
    image.value = pick.PickedFile("");
  }

  addToDb(String title) async {
    loading.value = true;
    await uploadFile();
    await firebase
        .collection("Testing")
        .doc(title)
        .set({"title": title, "image": _uploadedFileURL}).then((val) {
      loading.value = false;
      Get.showSnackbar(GetBar(
        message: "Created Catgeory",
      ));
    });
  }
}
