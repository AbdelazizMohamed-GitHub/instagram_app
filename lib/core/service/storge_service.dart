import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorgeService {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (image != null) {
      return await image.readAsBytes();
    } else {
      return null;
    }
  }

  static Future<String> uploadImage(
      {required Uint8List image, required String floderName}) async {
    String imageId = const Uuid().v1();

    var firestorge =
        FirebaseStorage.instance.ref().child(floderName).child(imageId);
    UploadTask uploadTask = firestorge.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  static Future<void> deleteImage(String url) async {
    var firestorge = FirebaseStorage.instance.refFromURL(url);
    firestorge.delete;
  }
}
