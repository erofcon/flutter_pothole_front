import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

Future<void> runDetection(
    DateTime dateTime,
    PlatformFile file,
    Function(dynamic send, dynamic total) uploadProgress,
    Function() uploadComplete,
    Function() uploadFailure) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('access');
  if (token != null) {
    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      String url = '$baseUrl/api/v1/detection/post/run';

      FormData formData = FormData.fromMap({
        'date': dateTime.toString(),
        'video': await MultipartFile.fromFile(file.path!, filename: file.name),
      });

      Response response = await Dio().post(url,
          data: formData,
          options: Options(headers: headers),
          onSendProgress: uploadProgress);

      if (response.statusCode! >= 200 && response.statusCode! < 210) {
        uploadComplete();
      } else {
        uploadFailure();
      }
    } catch (e) {
      uploadFailure();
    }
  }
}

Future<bool> createSingleTask(int categoryId, int executor, DateTime leadTime,
    {String? description,
    String? latitude,
    String? longitude,
    List<PlatformFile>? files}) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('access');
  if (token != null) {
    // try {
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    String url = '$baseUrl/api/v1/task/post/create';

    FormData formData = FormData.fromMap({
      'category': categoryId.toString(),
      'description': description ?? '',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'executor': executor.toString(),
      'leadDateTime': leadTime.toString(),
    });

    if (files != null) {
      for (PlatformFile file in files) {
        formData.files.addAll([
          MapEntry(
              "images",
              kIsWeb
                  ? MultipartFile.fromBytes(file.bytes!.toList(),
                      filename: file.name)
                  : await MultipartFile.fromFile(file.path!,
                      filename: file.name))
        ]);
      }
    }

    Response response = await Dio().post(
      url,
      data: formData,
      options: Options(headers: headers),
    );

    if (response.statusCode! >= 200 && response.statusCode! < 210) {
      print(true);
    } else {
      print(false);
    }
  }
  return false;
}
