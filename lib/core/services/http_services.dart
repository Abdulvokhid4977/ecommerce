import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AppConfig {
  static String baseUrl = "https://ulab-project.onrender.com/e_commerce/api/v1";
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class HttpResult {
  final bool isSuccess;
  final int status;
  final String body;

  HttpResult(this.isSuccess, this.status, this.body);
}

class ApiRequests {
  static Future<HttpResult> _result(response) async {
    dynamic body = response.body;
    int status = response.statusCode ?? 404;
    if(response.statusCode == 401) {
     if (kDebugMode) {
       print('Error');
     }
    }
    if(response.statusCode >= 200 && response.statusCode <= 299){
      return HttpResult(true, status, body);
    } else {
      return HttpResult(false, status, body);
    }
  }

  Future<HttpResult> get({required String slug}) async {
    Uri url = Uri.parse("${AppConfig.baseUrl}/$slug");
    try{
      final response =  await http.get(
          url,
      );
      return _result(response);
    }  catch (error) {
      log("Unexpected post error: $error");
      return _result({});
    }
  }


}