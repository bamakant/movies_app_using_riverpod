import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/env/env.dart';
import 'package:movies_app/service/api_urls.dart';

class API {
  static final API _api = API.init();
  late Dio _dio;
  final Connectivity _connectivity = Connectivity();
  bool connectionStatus = true;

  ///factory method to return single api instance
  factory API() {
    return _api;
  }

  API.init() {
    initDio();
    initConnectivity();
  }

  void initDio() {
    try {
      _dio = Dio(BaseOptions(
          baseUrl: ApiUrls.baseURI,
          connectTimeout: 180000,
          receiveTimeout: 600000));
    } catch (exception) {
      if (!kReleaseMode) log(exception.toString());
    }
  }

  Future<bool> initConnectivity() async {
    try {
      _connectivity.onConnectivityChanged.listen((event) async {
        switch (event) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.ethernet:
          case ConnectivityResult.mobile:
            connectionStatus = true;
            break;
          default:
            connectionStatus = false;
            break;
        }
      });
    } catch (error, stackTrace) {
      if (!kReleaseMode) log(stackTrace.toString());
    }
    return true;
  }

  Future<dynamic> getMovies(String category) async {
    try {
      return await _dio.get(
        '${ApiUrls.movieURI}/$category',
        queryParameters: {
          'api_key': Env.tmdbApiKey,
          'page': 1,
          'adult': false,
        },
      );
    } catch (exception, stackTrace) {
      if (!kReleaseMode) log(stackTrace.toString());
    }
    return null;
  }
}
