import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:image_picker/image_picker.dart';

final imageApiProvider = Provider(
  (ref) => ImageApi(FirebaseStorage.instance, ref.read(crashlyticsApiProvider)),
);

final fetchImageProvider = FutureProvider.family<String?, ImageSource>((
  ref,
  imageSource,
) async {
  final imageApi = ref.watch(imageApiProvider);

  return await imageApi.fetchImage(imageSource);
});

class ImageApi {
  ImageApi(this._firebaseStorage, this._crashlyticsApi);

  final FirebaseStorage _firebaseStorage;
  final CrashlyticsApi _crashlyticsApi;

  Future<String?> fetchImage(ImageSource imageSource) async {
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxHeight: 1200,
      maxWidth: 900,
      imageQuality: 50,
    );
    if (image == null) return null;

    var imageFile = File(image.path);

    return _firebaseStorage
        .ref()
        .child('uploads/$imageFile')
        .putFile(imageFile)
        .then((snapshot) => _downloadUrl(snapshot))
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(error, stackTrace, 'ImageApi', 'fetchImage');
        return null;
      },
    );
  }

  Future<String?> _downloadUrl(TaskSnapshot snapshot) async {
    return await snapshot.ref
        .getDownloadURL()
        .then<String?>(
          (url) => url,
        )
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(error, stackTrace, 'ImageApi', 'downloadUrl');
        return null;
      },
    );
  }
}
