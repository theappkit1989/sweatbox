import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'api_endpoint.dart';

class ApiHitter {
  static Dio? _dio;
  static CancelToken? _cancelToken;
  final GlobalKey key = new GlobalKey();

  Dio getDio() {
    if (_dio == null) {
      _dio = new Dio();
      _cancelToken = CancelToken();
      BaseOptions options = BaseOptions(
          baseUrl: ApiEndpoint.baseUrl,
          connectTimeout: const Duration(milliseconds: 300000),
          receiveTimeout: const Duration(milliseconds: 300000));
      _dio!.options = options;
      return _dio!;
    } else {
      return _dio!;
    }
  }

  Future<ApiResponse?> getApiResponse(String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Response response = await getDio().get(
              endPoint, options: Options(headers: headers),
              queryParameters: data);
          if (response.statusCode == 200) {
            return ApiResponse(true, response.statusCode!, response: response,
                msg: response.statusMessage!);
          }
          else if (response.statusCode == 401) {
            return ApiResponse(false, response.statusCode!, response: response,
                msg: response.statusMessage!);
          }
          else
            return ApiResponse(false, response.statusCode!, response: response,
                msg: response.statusMessage!);
        } catch (error) {
          return ApiResponse(false, 401, msg: 'Unauthorized');
        }
      } else
        return ApiResponse(false, 301, msg: "No Internet Connection");
    } catch (e) {
      return ApiResponse(false, 301, msg: "No Internet Connection");
    }
  }

  Future<ApiResponse?> getPostApiResponse(String endPoint,
      {Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        FormData? formData,
        bool isFormData = false}) async {
    try {
      print(data);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await getDio().post(endPoint,
              options: Options(headers: headers),
              data: isFormData ? formData : data,
              onSendProgress: (int sent, int total) {});
          if (response.statusCode == 200) {
            return ApiResponse(true, response.statusCode!, response: response,
                msg: response.statusMessage!);
          }
          else if (response.statusCode == 201) {
            return ApiResponse(true, response.statusCode!, response: response,
                msg: response.statusMessage!);
          }
          else
            return ApiResponse(false, response.statusCode!, response: response,
                msg: response.statusMessage!);
        } catch (error) {
          return ApiResponse(false, 401,
              msg: error.toString());
        }
      } else
        return ApiResponse(false, 301, msg: "No Internet Connection");
    } catch (e) {
      return ApiResponse(false, 301, msg: "No Internet Connection");
    }
  }

  Future<ApiResponse> getRawPostApiResponse(String endPoint,
      {Map<String, dynamic>? headers,
        String? data,
        FormData? formData,
        bool isFormData = false}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await getDio().post(endPoint,
              options: Options(headers: headers),
              data: isFormData ? formData : data,
              onSendProgress: (int sent, int total) {});
          if (response.statusCode == 200) {
            if (response.data["code"] == 200)
              return ApiResponse(
                  true, response.data["code"], response: response,
                  msg: response.data["message"]);
            else
              return ApiResponse(
                  false, response.data["code"], response: response,
                  msg: response.data["message"]);
          } else
            return ApiResponse(false, response.statusCode!, response: response,
                msg: response.statusMessage!);
        } catch (error) {
          return ApiResponse(false, 401, msg: error.toString());
        }
      } else
        return ApiResponse(false, 301, msg: "No Internet Connection");
    } catch (e) {
      return ApiResponse(false, 301, msg: "No Internet Connection");
    }
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null
        ? _cancelToken!.cancel('Cancelled')
        : cancelToken.cancel();
  }

}

class ApiResponse {
  final bool status;
  final int responseCode;
  final String msg;
  final Response? response;

  ApiResponse(this.status, this.responseCode,
      {this.msg = "Success", this.response});
}
