import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageApiProvider = Provider((_) => ImageApi(FirebaseStorage.instance));

final fetchImageProvider = FutureProvider((ref) async {
  final imageApi = ref.watch(imageApiProvider);

  return await imageApi.fetchImage();
});

class ImageApi {
  ImageApi(this._firebaseStorage);

  final FirebaseStorage _firebaseStorage;

  Future<String?> fetchImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return null;

    var imageFile = File(image.path);

    return _firebaseStorage
        .ref()
        .child('uploads/$imageFile')
        .putFile(imageFile)
        .then((snapshot) => _downloadUrl(snapshot))
        .onError((error, stackTrace) => _onError(error, stackTrace));
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

  String? _onError(Object? error, StackTrace stackTrace) {
    log(error.toString());
    log(stackTrace.toString());

    return null;
  }
}
