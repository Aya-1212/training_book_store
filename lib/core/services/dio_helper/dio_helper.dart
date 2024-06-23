import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:training_book_store/core/services/dio_helper/endpoints/auth_end_points.dart';

class DioHelper {
  //initialize Dio
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AuthEndPoints.baseUrl,
      /// I/flutter ( 4876): ║ The request connection took a /// longer than 0:00:00.000000 and it was aborted. /// To get rid of this exception, ///  try raising the RequestOptions.connectTimeout above the duration of 0:00:00.000000 or improve the response time of the server.
      connectTimeout: const Duration(seconds: 60),
      //no internet
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));
    dio!.interceptors.add(PrettyDioLogger());
// customization
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

//flutter pub add pretty_dio_logger
  //get data
  static Future<Response> getData(
      {required String url,
      String? token,
      required Map<String, dynamic>? query}) async {
    if (token != null) {
      dio!.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
    }

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic>? data,
      String? token}) async {
    if (token != null) {
      dio!.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return await dio!.post(url, data: data);
  }
}
