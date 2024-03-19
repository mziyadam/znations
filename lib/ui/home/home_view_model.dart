import 'package:flutter/cupertino.dart';
import 'package:znations/data/model/nation.dart';
import 'package:znations/data/repository/repository.dart';

class HomeViewModel with ChangeNotifier {
  String mQuery='';
  Nation dummy=Nation(id: 0, name: "Afghanistan", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Flag_of_Afghanistan_%282013–2021%29.svg/120px-Flag_of_Afghanistan_%282013–2021%29.svg.png", url: "https://en.wikipedia.org/wiki/Afghanistan", membershipWithinUN: "UN member state\n", sovereigntyDispute: " None\n", status: "The de facto ruling government, the  Islamic Emirate of Afghanistan, has not been recognised by any state. The United Nations continues to recognise the  Islamic Republic of Afghanistan as the government of Afghanistan.[5][6]\n"
  );
  List<Nation> nationsSource = [Nation(id: 0, name: "Afghanistan", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Flag_of_Afghanistan_%282013–2021%29.svg/120px-Flag_of_Afghanistan_%282013–2021%29.svg.png", url: "https://en.wikipedia.org/wiki/Afghanistan", membershipWithinUN: "UN member state\n", sovereigntyDispute: " None\n", status: "The de facto ruling government, the  Islamic Emirate of Afghanistan, has not been recognised by any state. The United Nations continues to recognise the  Islamic Republic of Afghanistan as the government of Afghanistan.[5][6]\n"
  )];
  List<Nation> nations = [];

  void setMQuery(String query){
    mQuery=query;
    notifyListeners();
  }

  void getData() async{
    nationsSource=await Repository().getData();
    nations=nationsSource;
    notifyListeners();
  }

  void refresh() async{
    nationsSource=await Repository().getData();
    nations=nationsSource.where((i) => i.name!.toLowerCase().contains(mQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void search(String query){
    mQuery=query;
    nations=nationsSource.where((i) => i.name!.toLowerCase().contains(mQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
