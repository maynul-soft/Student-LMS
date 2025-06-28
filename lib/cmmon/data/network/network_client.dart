import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final List<dynamic>? listBody;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.listBody,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Map<String, String> headers = {};
      Uri uri = Uri.parse(url);
      _preRequestLog(url: url, headers: headers);
      Response response = await get(uri, headers: headers);
      _postRequestLog(
        response.statusCode,
        url,
        headers: response.headers,
        body: response.body,
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if(decodedJson.runtimeType == List<dynamic>){
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            listBody: decodedJson,
          );

        }else{
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson,
          );
        }


      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Login Expired',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _postRequestLog(-1, url);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'Application/json',
      };
      _preRequestLog(url: url, body: body, headers: headers);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _postRequestLog(
        response.statusCode,
        url,
        body: jsonDecode(response.body),
        headers: response.headers,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Login Expired',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'];
        _postRequestLog(-1, url, errorMessage: errorMessage);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _postRequestLog(-1, url, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> multiPartRequest(
      {required String url,
        required Map<String,String>fields,
        List<MultipartFile>? file
      }) async {
    try {
      Uri uri = Uri.parse(url);
      MultipartRequest request = MultipartRequest('POST', uri);

      request.fields.addAll(fields);


     if(file != null){
       request.files.addAll(file);
     }

      _preRequestLog(url: url, body: request.fields);

      StreamedResponse streamedResponse = await request.send();

      Response response = await Response.fromStream(streamedResponse);

      _postRequestLog(
        response.statusCode,
        url,
        body: response.body,
      );

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        _logger.i(response.body);

        if(decodedJson.runtimeType == List<dynamic>){
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            listBody: decodedJson,
          );

        }else{
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson,
          );
        }
      } else {
        var decodedJson = jsonDecode(response.body);
        _logger.i(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            body: decodedJson);
      }
    } catch (e) {
      _logger.i(e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void _preRequestLog({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    _logger.i(
      '++++++ THIS IS FROM PRE REQUEST LOG++++++++'
      'Url => $url\n'
      'Body: ${body ?? ''}\n'
      'Headers ==>> $headers',
    );
  }

  static void _postRequestLog(
    int statusCode,
    String url, {
    dynamic body,
    Map<String, dynamic>? headers,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        ''
        'Url: $url\n'
        'Status code: $statusCode\n'
        'Error Message: $errorMessage',
      );
    } else {
      _logger.i(
        'Url: $url\n'
        'Status code: $statusCode\n'
        'Headers: $headers\n'
        'Response: $body',
      );
    }
  }
}
