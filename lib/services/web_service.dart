import 'dart:html';

import 'package:large_file_uploader/large_file_uploader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

Future<void> runDetection(DateTime dateTime, File file, Function(dynamic progress) uploadProgress, Function(dynamic responce) uploadComplete, Function() uploadFailure) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('access');
  final largeFileUploader = LargeFileUploader();

  if (token != null) {
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    String url = '$baseUrl/api/v1/detection/post/run';

    largeFileUploader.upload(
        headers: headers,
        uploadUrl: url,
        onSendProgress: uploadProgress,
        onComplete: uploadComplete,
        onFailure: uploadFailure,
        data: {
          'date': dateTime.toString(),
          'video': file,
        });
  }
}
