import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
// import 'package:mvvm_flutter_app/model/apis/app_exception.dart';

class ApiService {
  final String _baseUrl =
      "https://raw.githubusercontent.com/mziyadam/znation-data/main/znation_data/nations.json";

  Future<dynamic> get() async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
