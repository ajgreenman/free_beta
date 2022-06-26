import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:image_picker/image_picker.dart';

final mediaApiProvider = Provider(
  (ref) => MediaApi(FirebaseStorage.instance, ref.read(crashlyticsApiProvider)),
);

final fetchImageProvider = FutureProvider.family<String?, ImageSource>((
  ref,
  imageSource,
) async {
  final mediaApi = ref.watch(mediaApiProvider);

  return await mediaApi.fetchImage(imageSource);
});

final fetchVideoProvider = FutureProvider.family<String?, ImageSource>((
  ref,
  imageSource,
) async {
  final mediaApi = ref.watch(mediaApiProvider);

  return await mediaApi.fetchVideo(imageSource);
});

class MediaApi {
  MediaApi(this._firebaseStorage, this._crashlyticsApi);

  final FirebaseStorage _firebaseStorage;
  final CrashlyticsApi _crashlyticsApi;

  Future<String?> fetchVideo(ImageSource imageSource) async {
    var video = await ImagePicker().pickVideo(
      source: imageSource,
    );

    if (video == null) return null;

    return _downloadFile(video, 'fetchVideo');
  }

  Future<String?> fetchImage(ImageSource imageSource) async {
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxHeight: 1200,
      maxWidth: 900,
      imageQuality: 50,
    );

    if (image == null) return null;

    return _downloadFile(image, 'fetchImage');
  }

  Future<String?> _downloadFile(XFile xFile, String method) {
    var file = File(xFile.path);

    return _firebaseStorage
        .ref()
        .child('uploads/$file')
        .putFile(file)
        .then((snapshot) => _downloadUrl(snapshot))
        .onError(
      (error, stackTrace) {
        _crashlyticsApi.logError(error, stackTrace, 'MediaApi', method);
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
        _crashlyticsApi.logError(error, stackTrace, 'MediaApi', 'downloadUrl');
        return null;
      },
    );
  }
}
