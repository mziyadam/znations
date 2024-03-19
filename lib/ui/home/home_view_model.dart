import 'package:flutter/cupertino.dart';

class HomeViewModel with ChangeNotifier {
  String mQuery='';
  List<String> nationsSource = ['algeria', 'nigeria'];
  List<String> nations = [];

  void setMQuery(String query){
    mQuery=query;
    notifyListeners();
  }
  void getData(){
    nations=nationsSource;
    notifyListeners();
  }
  void search(String query){
    mQuery=query;
    nations=nationsSource.where((i) => i.contains(mQuery))
        .toList();
    notifyListeners();
  }
  // Future<List<Singer>> getData() {
  //   Future<List<Singer>> tes = LyricsRepository().getSingersOnly();
  //   return tes;
  // }

}
