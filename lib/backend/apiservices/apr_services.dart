import 'dart:io';
import 'dart:convert' as convert;
// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/session_manager.dart';

mixin ApiServices {
  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',

  };

  Future<Dio> getDio() async {
    Dio dio;
    // String baseUrl = 'https://api.vensemart.com/api/';

    String baseUrl = 'https://api.dojah.io/api/';



    BaseOptions _options = BaseOptions(
      baseUrl: baseUrl,
      headers: _requestHeaders,
      connectTimeout: Duration(days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: 200000, microseconds: 0),
      receiveTimeout: Duration(days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: 200000, microseconds: 0),
    );

    dio = Dio(_options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // const bool isProduction = bool.fromEnvironment('dart.vm.product');
    // if (!isProduction) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    // }

    return dio;
  }

  Future<Response?> apiPostRequests(
      String endPoint, Map<String, dynamic> credentials,
      {Map<String, dynamic>? header}) async {
    try {
      header ??= {};
      Dio dio = await getDio();
      Response response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            // ignore: prefer_interpolation_to_compose_strings
            "AppId": "639b0afe93de39003589f6c8",
            "Authorization" : "prod_sk_Pu8TT2lVDSYu32eONq5d7phaj",
            ...header
          }));
      return response;
    } on DioError catch (e) {
      // debugPrint("e.toString()");
      print(e.toString());
      // return "";
      return e.response;
    }
  }

  Future<Response?> apiGetRequests(String endPoint) async {
    try {
      Dio dio = await getDio();
      Response response = await dio.get(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      //  debugPrint(response.data.toString());
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Map<String, dynamic>?> apiUploadPostRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      Dio dio = await getDio();
      final response = await dio.post(endPoint,
          data: FormData.fromMap(credentials),
          options: Options(headers: {

            "Content-Type": "multipart/form-data",
            "AppId": "639b0afe93de39003589f6c8",
            "Authorization" : "prod_sk_Pu8TT2lVDSYu32eONq5d7phaj",
          }));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  catchError(DioError e) {
    if (e.message.toString().contains("SocketException")) {
      throw ({
        "status": "error",
        "message": "Network Error! Check your internet connection."
      });
    }

    if (e.message.toString().contains("timed out")) {
      throw ({"status": "error", "message": "Connection timeout."});
    }

    if (e.message.toString().contains("CONNECT_TIMEOUT")) {
      return {"status": "error", "message": "Connection timeout."};
    }

    if (e.message.runtimeType.toString() == "String") {
      return {"status": "error", "message": e.message};
    }

    if (e.response?.statusCode == 422) {
      return {
        "status": "error",
        "message": e.response?.data?["data"],
        "email": e.response?.data?["data"]["errors"]["email"]
      };
    }

    if (e.response != null) {
      checkForExpiredToken(e);

      return {
        "status": "error",
        "message": e.response?.data,
      };
    } else {
      return {
        "status": "error",
        "message": "Error connecting to network!",
      };
    }
  }

  getAuthToken() async {
    String? accessToken = SessionManager.instance.authToken;
    return accessToken;
  }

  checkForExpiredToken(DioError e) {
    if (e.response != null &&
        e.response!.data.runtimeType.toString().toLowerCase().contains("map")) {
      if (e.response!.data["message"]
          .toString()
          .toLowerCase()
          .contains("unauthenticated")) {
        GetIt locator = GetIt.instance;
        // final NavigationService _navigationService =
        //     locator<NavigationService>();
        // _navigationService.logOut();
      }
    }
  }
}
