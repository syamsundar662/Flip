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

  Future<File?> imagePicker(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Future<String?> pickImage(ImageSource imageSource) async {
  //   late PermissionStatus status;
  //   if (imageSource == ImageSource.camera) {
  //     status = await Permission.camera.request();
  //   } else {
  //     status = await Permission.camera.request();
  //   }
  //   if (status != PermissionStatus.granted) {
  //     return null;
  //   }
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: imageSource);
  //   if (image != null) {
  //     return image.path;
  //   }
  //   return null;
  // }

  Future<List<String>> uploadImages(List<String> imageFiles) async {
    List<String> downloadUrls = [];

    for (var imageFile in imageFiles) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(imageFile));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }
}
