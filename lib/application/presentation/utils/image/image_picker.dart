import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PickImage {
 Future<List<File>> multiImagePicker() async {
    final picker = ImagePicker();
    final List<File> paths = [];
    final selectedFiles = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    for (var element in selectedFiles) {
      paths.add(File(element.path));
    }
    return paths; 
  }

  Future<List<String>> uploadImages(List<File> imageFiles) async {
    List<String> downloadUrls = [];

    for (File imageFile in imageFiles) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }
}
