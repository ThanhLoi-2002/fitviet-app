import 'dart:convert';
import 'dart:io';
import 'package:fitness_client/api/api_checker.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'Không thể kết nối đến máy chủ'.tr;
  final int timeoutInSeconds = 40;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      print('Token: $token');
    }

    updateHeader(token);
  }

  Map<String, String> updateHeader(String? token, {bool setHeader = true}) {
    Map<String, String> header = {};

    header.addAll({'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'});
    if (setHeader) {
      _mainHeaders = header;
    }
    return header;
  }

  Map<String, String> getHeader() => _mainHeaders;

  Future<ResponseModel> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call getData: ${appBaseUrl + uri}'); //\nHeader: ${headers ?? _mainHeaders}
      }
      http.Response response = await http.get(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      if (kDebugMode) {
        print('------------${e.toString()}');
      }
      return ResponseModel(statusCode: 1, message: noInternetMessage, isSuccess: false);
    }
  }

  Future<ResponseModel> postData(String uri, dynamic body, {Map<String, String>? headers, int? timeout, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call postData: ${appBaseUrl + uri}'); //\nHeader: ${headers ?? _mainHeaders}
        print('====> API Body postData: $body');
      }

      Map<dynamic, dynamic> newBody = {};
      if (body != null) {
        body.forEach((key, value) {
          if (value != null && value.toString().isNotEmpty) {
            newBody.addAll({key: value});
          }
        });
      }

      http.Response response = await http.post(Uri.parse(appBaseUrl + uri), body: jsonEncode(newBody), headers: headers ?? _mainHeaders).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return ResponseModel(statusCode: 1, message: noInternetMessage, isSuccess: false);
    }
  }

  Future<ResponseModel> postMultipartData(
    String uri,
    Map<String, String> body,
    List<MultipartBody> multipartBody, {
    List<MultipartDocument>? multipartDoc,
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      debugPrint('====> API Call postMultipartData: ${appBaseUrl + uri}\nHeader: $_mainHeaders');
      debugPrint('====> API Body postMultipartData: $body with ${multipartBody.length} and multipart ${multipartDoc?.length}');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          if (kIsWeb) {
            Uint8List list = await multipart.file!.readAsBytes();
            http.MultipartFile part = http.MultipartFile(
              multipart.key,
              multipart.file!.readAsBytes().asStream(),
              list.length,
              filename: basename(multipart.file!.path),
              contentType: MediaType('image', 'jpg'),
            );
            request.files.add(part);
          } else {
            File file = File(multipart.file!.path);
            request.files.add(http.MultipartFile(multipart.key, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
          }
        }
      }

      if (multipartDoc != null && multipartDoc.isNotEmpty) {
        for (MultipartDocument file in multipartDoc) {
          File other = File(file.file!.files.single.path!);
          Uint8List list0 = await other.readAsBytes();
          var part = http.MultipartFile(file.key, other.readAsBytes().asStream(), list0.length, filename: basename(other.path));
          request.files.add(part);
        }
      }

      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return ResponseModel(statusCode: 1, message: noInternetMessage, isSuccess: false);
    }
  }

  Future<ResponseModel> putData(String uri, dynamic body, {Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call putData: ${appBaseUrl + uri}'); //\nHeader: ${headers ?? _mainHeaders}
        print('====> API Body putData: $body');
      }
      http.Response response = await http.put(Uri.parse(appBaseUrl + uri), body: jsonEncode(body), headers: headers ?? _mainHeaders).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return ResponseModel(statusCode: 1, message: noInternetMessage, isSuccess: false);
    }
  }

  Future<ResponseModel> deleteData(String uri, {Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call deleteData: ${appBaseUrl + uri}'); //\nHeader: ${headers ?? _mainHeaders}
      }
      http.Response response = await http.delete(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return ResponseModel(statusCode: 1, message: noInternetMessage, isSuccess: false);
    }
  }

  ResponseModel handleResponse(http.Response response, String uri, bool handleError) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    ResponseModel response0 = ResponseModel.fromJson(body);
    if (kDebugMode) {
      print('====> API Response: [${response0.statusCode}] $uri');
      if (response.statusCode != 500) {
        print('data: ${response0.data}');
        print('message: ${response0.message}');
      }
    }
    if (handleError) {
      if (response0.statusCode == 200) {
        return response0;
      } else {
        ApiChecker.checkApi(response0);
      }
    }
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}

class MultipartDocument {
  String key;
  FilePickerResult? file;
  MultipartDocument(this.key, this.file);
}
