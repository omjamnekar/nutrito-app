import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseHttpCall {
  late final Dio _dio;

  BaseHttpCall() {
    try {
      final String baseUrl =
          dotenv.env['BASEURL'] ?? 'https://nutrito.vercel.app/api';

      _dio = Dio(BaseOptions(baseUrl: baseUrl));

      // Add interceptors
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ));
    } on DioException catch (e) {
      print('Dio setup error: ${e.message}');
    } catch (e) {
      print('Unexpected error during Dio setup: $e');
    }
  }

  Dio get sendRequest => _dio;
}

class GenApi {
  final Dio _dio = Dio();

  Dio get sendRequest => _dio;

  GenApi() {
    try {
      _dio.options.baseUrl = dotenv.env["PYTHONVERCEL"] ??
          "https://nutrito-prompt-server-muot.vercel.app";
    } on DioException catch (e) {
      print(e.error.toString());
    }
  }
}
