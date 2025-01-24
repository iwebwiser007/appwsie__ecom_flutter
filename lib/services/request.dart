import 'dart:async';
import 'dart:convert';

import 'package:appwise_ecom/extensions/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/app_constant.dart';
import '../utils/colors.dart';
import '../utils/text_utility.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String? error;
  final String? message;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.error,
    this.message,
  });
}

class RequestUtils {
  Future<ApiResponse<T>> _handleRequest<T>({
    required Future<http.Response> Function() requestFunction,
    int timeoutDurationSeconds = 30,
    required String apiUrl,
  }) async {
    try {
      final response = await requestFunction().timeout(
        Duration(seconds: timeoutDurationSeconds),
      );
      AppConst.log("$apiUrl--response", json.decode(response.body));
      AppConst.log("statusCode", response.statusCode);
      if (response.statusCode == 400) {
        // AppConst.getOuterContext()?.pushReplace(LoginScreen());
        // Utils.snackBar('Session expired. Please log in again.', AppConst.getOuterContext()!);
        // final tokenRefreshed = await refreshToken();
        // if (tokenRefreshed) {
        //   return _handleRequest<T>(
        //     requestFunction: requestFunction,
        //     timeoutDurationSeconds: timeoutDurationSeconds,
        //     apiUrl: apiUrl,
        //   );
        // } else {
        return ApiResponse<T>(
          statusCode: 400,
          error: 'Session expired. Please log in again.',
          message: json.decode(response.body)['message'],
        );
        // }
        // await showSessionExpiredDialog();
        // AppConst.setAccessToken(null);
        // AppConst.setRefreshToken(null);
        // UserHiveMethods.clear();
        // AppConst.getOuterContext()?.pushNamedAndRemoveUntil(RoutePath.loginScreen);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>(
          statusCode: response.statusCode,
          data: json.decode(response.body) as T,
          message: json.decode(response.body)['message'],
        );
      } else {
        return ApiResponse<T>(
          statusCode: response.statusCode,
          error: json.decode(response.body)["message"] ?? "Unknown error occur Please again later",
          message: json.decode(response.body)['message'],
        );
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return ApiResponse<T>(
        statusCode: 408,
        error: 'Timeout error. Please check your internet connection and try again.',
      );
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      return ApiResponse<T>(
        statusCode: 500,
        error: 'An error occurred. Please try again.',
      );
    }
  }

  Future<ApiResponse<dynamic>> getRequest({
    required String url,
    Map<String, String>? headers,
    int? duration,
  }) async {
    AppConst.log(
      "headers",
      headers ??
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppConst.getAccessToken()}',
          },
    );
    AppConst.log("url", url);
    Future<http.Response> requestFunction() {
      return http.get(
        Uri.parse(url),
        headers: headers ??
            {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AppConst.getAccessToken()}',
            },
      );
    }

    return _handleRequest<dynamic>(
      requestFunction: requestFunction,
      timeoutDurationSeconds: duration ?? 30,
      apiUrl: url,
    );
  }

  Future<ApiResponse<dynamic>> postRequest({
    required String url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
    String method = 'POST',
  }) async {
    AppConst.log("headers", headers);
    AppConst.log("url", url);
    AppConst.log("body", body);
    AppConst.log(
      "token",
      AppConst.getAccessToken(),
    );

    Future<http.Response> requestFunction() {
      if (method == 'PUT') {
        return http.put(
          Uri.parse(url),
          headers: headers ??
              {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${AppConst.getAccessToken()}',
              },
          body: jsonEncode(body),
        );
      } else {
        return http.post(
          Uri.parse(url),
          headers: headers ??
              {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${AppConst.getAccessToken()}',
              },
          body: jsonEncode(body),
        );
      }
    }

    return _handleRequest<dynamic>(
      requestFunction: requestFunction,
      apiUrl: url,
    );
  }

  Future<ApiResponse<dynamic>> formDataPostRequest({
    required String url,
    required Map<String, dynamic> fields,
    required Map<String, dynamic> imageMap,
    bool encodeDataTrue = false,
  }) async {
    AppConst.log("headers", {
      'Accept': '*/*',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${AppConst.getAccessToken()}',
    });
    AppConst.log("url", url);
    AppConst.log("imageMap", imageMap);
    AppConst.log("fields", jsonEncode(fields));
    Future<http.Response> requestFunction() async {
      final multipartRequest = http.MultipartRequest('POST', Uri.parse(url));
      multipartRequest.headers.addAll({
        'Accept': '*/*',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${AppConst.getAccessToken()}',
      });
      fields.forEach((key, value) {
        if (encodeDataTrue) {
          multipartRequest.fields[key] = jsonEncode(value);
        } else {
          multipartRequest.fields[key] = value.toString();
        }
      });
      for (var entry in imageMap.entries) {
        if (entry.value != null) {
          if ((entry.value.startsWith("http://") || entry.value.startsWith("https://"))) {
            final imageMultipartFile = http.MultipartFile.fromString(entry.key, entry.value);
            multipartRequest.files.add(imageMultipartFile);
          } else {
            final imageMultipartFile = await http.MultipartFile.fromPath(entry.key, entry.value);
            multipartRequest.files.add(imageMultipartFile);
          }
        }
      }
      final streamedResponse = await multipartRequest.send();
      final responseString = await streamedResponse.stream.bytesToString();
      return http.Response(responseString, streamedResponse.statusCode);
    }

    return _handleRequest<dynamic>(
      requestFunction: requestFunction,
      apiUrl: url,
    );
  }
}

// Future<bool> refreshToken() async {
//   final response = await http.get(
//     Uri.parse(ServiceUrl.refreshTokenUrl),
//     headers: {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${AppConst.getRefreshToken()}',
//     },
//   );
//   AppConst.log("RefreshtokenBody-----", response.body.toString());
//   AppConst.log("RefreshToken-----", AppConst.getRefreshToken());
//   if (response.statusCode == 200) {
//     final newToken = json.decode(response.body)["data"]['accessToken'];
//     AppConst.setAccessToken(newToken);
//     // UserHiveMethods.addData(key: "access_token", data: newToken);
//     return true;
//   } else {
//     await showSessionExpiredDialog();
//     AppConst.setAccessToken(null);
//     AppConst.setRefreshToken(null);
//     // UserHiveMethods.clear();
//     AppConst.getOuterContext()?.pushNamedAndRemoveUntil(RoutePath.loginScreen);
//     return false;
//   }
// }

Future<void> showSessionExpiredDialog() {
  final context = AppConst.getOuterContext();
  return showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const AppText(text: 'Session Expired', fontsize: 16),
        content: const AppText(
          text: 'Your session has expired. Please log in again.',
          fontsize: 13,
          textColor: AppColor.secondary,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: const AppText(text: 'OK'),
          ),
        ],
      );
    },
  );
}
