import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/login_request.dart';
import 'package:flutter_pothole_front/services/shared_service.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:large_file_uploader/large_file_uploader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';
import '../models/related_user_model.dart';
import '../models/task_category_response.dart';
import '../models/task_statistic_response.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequest model) async {
    try {
      var url = Uri.parse('$baseUrl/api/v1/token/');
      var response = await client.post(url, body: model.toJson());

      if (response.statusCode == 200) {
        await SharedService.setUser(
            loginResponse(utf8.decode(response.bodyBytes)));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  static Future<TaskStatistic?> getTaskStatistic() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var url = Uri.parse('$baseUrl/api/v1/task/get/counttask');
      var response = await client.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return taskStatistic(response.body);
      } else if (response.statusCode > 400) {
        Modular.to.navigate('/login');
      }
    }

    return null;
  }

  static Future<List<TaskCategory>> getTaskCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var url = Uri.parse('$baseUrl/api/v1/task/get/category');
      var response = await client.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final res = jsonDecode(utf8.decode(response.bodyBytes)) as List;

        return List<TaskCategory>.from(
            res.map((dynamic row) => TaskCategory.fromJson(row)));
      } else if (response.statusCode > 400) {
        Modular.to.navigate('/login');
      }
    }
    return [];
  }

  static Future<List<RelatedUser>> getRelatedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var url = Uri.parse('$baseUrl/api/v1/token/related_user');
      var response = await client.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final res = jsonDecode(utf8.decode(response.bodyBytes)) as List;

        return List<RelatedUser>.from(
            res.map((dynamic row) => RelatedUser.fromJson(row)));
      } else if (response.statusCode > 400) {
        Modular.to.navigate('/login');
      }
    }
    return [];
  }

  static Future<bool> createSingleTask(int categoryId, int executor,
      DateTime leadTime,
      {String? description,
        String? latitude,
        String? longitude,
        PlatformFile? file}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var url = Uri.parse('$baseUrl/api/v1/task/post/create');
      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'category': categoryId.toString(),
        'description': description ?? '',
        'latitude': latitude ?? '',
        'longitude': longitude ?? '',
        'executor': executor.toString(),
        'leadDateTime': leadTime.toString()
      });

      request.headers.addAll(headers);

      if (file != null) {
        request.files.add(http.MultipartFile.fromBytes(
            'images', file.bytes!.toList(),
            filename: file.name));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode >= 200 || response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }


  static Future<bool> runDetection(
      DateTime dateTime, File? file, LargeFileUploader largeFileUploader) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      var url = '$baseUrl/api/v1/detection/post/run';

      largeFileUploader.upload(headers: headers, uploadUrl: url, onSendProgress: (progress){
        print(progress);
      }, data: {
        'date':dateTime.toString(),
        'video': file,
      });



      // var request = http.MultipartRequest('POST', url);
      //
      // request.fields.addAll({
      //   'date': dateTime.toString(),
      // });
      //
      // request.headers.addAll(headers);
      //
      // if (file != null) {
      //   request.files.add(http.MultipartFile.fromBytes(
      //       'video', file.bytes!.toList(),
      //       filename: file.name));
      // }
      //
      // http.StreamedResponse response = await request.send();
      //
      // if (response.statusCode >= 200 || response.statusCode < 300) {
      //   return true;
      // } else {
      //   return false;
      // }
    }
    return false;
  }

  // static Future<bool> runDetection(DateTime dateTime, XFile? file) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('access');
  //   if (token != null) {
  //     Map<String, String> headers = {"Authorization": "Bearer $token"};
  //
  //     var url = Uri.parse('$baseUrl/api/v1/detection/post/run');
  //     var request = http.MultipartRequest('POST', url);
  //     request.headers.addAll(headers);
  //     Uint8List data = await file!.readAsBytes();
  //
  //     List<int> list = data.cast();
  //
  //     request.fields.addAll({
  //       'date': dateTime.toString(),
  //     });
  //
  //     request.files.add(http.MultipartFile.fromBytes(
  //         'video', list,
  //         filename: file.name));
  //
  //     http.StreamedResponse response = await request.send();
  //     print(response.statusCode);
  //     if (response.statusCode >= 200 || response.statusCode < 300) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  //   return false;
  // }


// static Future<bool> runDetection(
//     DateTime dateTime, PlatformFile? file) async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('access');
//   if (token != null) {
//     Map<String, String> headers = {"Authorization": "Bearer $token"};
//
//     var url = Uri.parse('$baseUrl/api/v1/detection/post/run');
//     var request = http.MultipartRequest('POST', url);
//
//     request.fields.addAll({
//       'date': dateTime.toString(),
//     });
//
//     request.headers.addAll(headers);
//
//     if (file != null) {
//       // request.files.add(http.MultipartFile(
//       //     "Your parameter name on server side",
//       //     file.readStream!,
//       //     file.size,
//       //     filename: file.name));
//
//
//       request.files.add(http.MultipartFile.fromBytes(
//           'video', file.bytes!.toList(growable: false),
//           filename: file.name));
//     }
//
//     http.StreamedResponse response = await request.send();
//     print(response.statusCode);
//     if (response.statusCode >= 200 || response.statusCode < 300) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//   return false;
// }

// static Future<bool> runDetection(DateTime dateTime, PlatformFile? file,
//     void Function(double k) upload) async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('access');
//   if (token != null) {
//     Map<String, String> headers = {"Authorization": "Bearer $token"};
//
//     String url = '$baseUrl/api/v1/detection/post/run';
//
//     FormData formData = FormData.fromMap({
//       'date': dateTime.toString(),
//       'video':
//           MultipartFile.fromBytes(file!.bytes!.toList(), filename: file.name)
//     });
//
//     Response response = await Dio().post(url,
//         data: formData,
//         options: Options(headers: headers), onSendProgress: (send, total) {
//       upload((send / total * 100));
//     });
//
//     print(response.statusCode);
//   }
//
//   return false;
//
//   // return false;
// }

// static Future<bool> runDetection(
//     DateTime dateTime, PlatformFile? file) async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('access');
//   if (token != null) {
//     Map<String, String> headers = {"Authorization": "Bearer $token"};
//
//     var url = Uri.parse('$baseUrl/api/v1/detection/post/run');
//     var request = http.MultipartRequest('POST', url);
//
//     request.fields.addAll({
//       'date': dateTime.toString(),
//     });
//
//     request.headers.addAll(headers);
//
//     if (file != null) {
//       request.files.add(http.MultipartFile.fromBytes(
//           'video', file.bytes!.toList(),
//           filename: file.name));
//     }
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode >= 200 || response.statusCode < 300) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//   return false;
// }
}
