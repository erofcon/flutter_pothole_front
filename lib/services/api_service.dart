import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/login_request.dart';
import 'package:flutter_pothole_front/models/task_response_model.dart';
import 'package:flutter_pothole_front/models/task_list_response_model.dart';
import 'package:flutter_pothole_front/services/shared_service.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:http/http.dart' as http;

// import 'package:large_file_uploader/large_file_uploader.dart';
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
      // client.close();
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

  static Future<bool> createSingleTask(
      int categoryId, int executor, DateTime leadTime,
      {String? description,
      String? latitude,
      String? longitude,
      List<PlatformFile>? files}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      try {
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
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  static Future<TaskResponseModel?> getDetailTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');

    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      String url = '$baseUrl/api/v1/task/get/$taskId';

      Response response =
          await d.Dio().get(url, options: d.Options(headers: headers));

      TaskResponseModel model = taskResponseModel(response.toString());
      return model;
    }
    return null;
  }

  static Future<bool> runDetection(DateTime dateTime, PlatformFile file) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      String url = '$baseUrl/api/v1/detection/post/run';

      d.FormData formData = d.FormData.fromMap({
        'date': dateTime.toString(),
        'video': await d.MultipartFile.fromFile(file.path!, filename: file.name
            //show only filename from path
            ),
      });

      print(formData);

      d.Response response = await d.Dio().post(url,
          data: formData,
          options: d.Options(headers: headers), onSendProgress: (send, total) {
        print((send / total * 100));
      });

      print(response.statusCode);
    }
    return false;
  }

  static Future<Map<String, dynamic>> createAnswer(String taskId,
      {String? description, List<PlatformFile>? files}) async {
    Map<String, dynamic> response;

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      try {
        Map<String, String> headers = {"Authorization": "Bearer $token"};

        String url = '$baseUrl/api/v1/answer/post/create';

        FormData formData = FormData.fromMap({
          'task': taskId,
          'description': description ?? '',
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

        Response resp = await Dio().post(
          url,
          data: formData,
          options: Options(headers: headers),
        );

        if (resp.statusCode! >= 200 && resp.statusCode! < 210) {
          return response = {'completed': true, 'response': resp.toString()};
        } else {
          return response = {'completed': false, 'response': resp.toString()};
        }
      } catch (e) {
        return response = {'completed': false, 'response': ''};
      }
    }
    return response = {'completed': false, 'response': ''};
  }

  static Future<bool> closeTask(String taskId) async {

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      try {
        Map<String, String> headers = {"Authorization": "Bearer $token"};

        String url = '$baseUrl/api/v1/task/put/update/$taskId';

        Response resp = await Dio().put(
          url,
          options: Options(headers: headers),
        );


        if (resp.statusCode! >= 200 && resp.statusCode! < 210) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  static Future<String?> getTaskList() async {

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access');
    if (token != null) {
      try {
        Map<String, String> headers = {"Authorization": "Bearer $token"};

        String url = '$baseUrl/api/v1/task/get';

        Response resp = await Dio().get(
          url,
          options: Options(headers: headers),
        );


        if (resp.statusCode! >= 200 && resp.statusCode! < 210) {
          return resp.toString();
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
