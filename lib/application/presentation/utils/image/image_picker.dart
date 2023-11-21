import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PickImage {
  final picker = ImagePicker();
  Future<List<File>> multiImagePicker() async {
    final List<File> paths = [];
    final selectedFiles = await picker.pickMultiImage();
    for (var element in selectedFiles) {
      paths.add(File(element.path));
    }
    return paths;
  }

  Future<File?> imagePicker(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

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

  Future<String> uploadImage(String imageFiles) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(File(imageFiles));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//cropimage

  Future<String?> pickAndCropImage() async {
    final picker = ImagePicker();
    String? croppedDone;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      croppedDone = await cropImage(pickedFile.path);
    }
    return croppedDone;
  }

  Future<String?> cropImage(String imagePath) async {
    String? cropperFilePath;
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
      ],
    );

    if (croppedFile != null) {
      cropperFilePath = croppedFile.path;
    }
    return cropperFilePath;
  }
}
