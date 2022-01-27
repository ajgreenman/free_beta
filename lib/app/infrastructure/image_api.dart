import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageApiProvider = Provider((_) => ImageApi());

final fetchImageProvider = FutureProvider((ref) async {
  final imageApi = ref.watch(imageApiProvider);

  return await imageApi.fetchImage();
});

class ImageApi {
  Future<String?> fetchImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return null;

    var imageFile = File(image.path);

    return FirebaseStorage.instance
        .ref()
        .child('uploads/$imageFile')
        .putFile(imageFile)
        .then((snapshot) => _downloadUrl(snapshot));
  }

  Future<String?> _downloadUrl(TaskSnapshot snapshot) async {
    return await snapshot.ref
        .getDownloadURL()
        .then<String?>(
          (url) => url,
        )
        .onError(
      (error, stackTrace) {
        log(error.toString() + '\n\n' + stackTrace.toString());
        return null;
      },
    );
  }
}
