import 'package:dio/dio.dart';
import 'package:nutrito/data/api.dart';

class GenaiCall {
  GenApi _genApi = GenApi("", "");

  Future<void> fetchPost() async {
    try {
      Response response = await _genApi.sendRequest.get("/initialPrompt");
    } on DioException catch (e) {}
  }
}
