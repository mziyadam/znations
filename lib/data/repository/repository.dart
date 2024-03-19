import 'package:znations/data/model/nation.dart';
import 'package:znations/data/service/api_service.dart';

class Repository{

  final ApiService _apiService = ApiService();

  Future<List<Nation>> getData() async {
    dynamic response = await _apiService.get();
    final jsonData = response as List;
    List<Nation> nations =
    jsonData.map((tagJson) => Nation.fromJson(tagJson)).toList();
    return nations;
  }
}