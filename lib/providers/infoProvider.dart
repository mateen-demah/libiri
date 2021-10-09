import 'package:flutter/material.dart';

class InfoProvider with ChangeNotifier{
  Map<String, dynamic> _info = {"number1": null, "number2": null, "numOfSims": null, "operator1": null, "operator2": null};

  Map<String, dynamic> get info{
    return {..._info};
  }

  void updateInfo(String key, var newInfo, {bool notify = true}){
    _info[key] = newInfo;
    if (notify==true) {
      notifyListeners();
    }
  }
}