import 'package:flutter/material.dart';
import '../ApiHelper/skyScrapperApiHelper.dart';
import '../Model/skyScrapperModel.dart';
import '../View/skyScrapperSearchPage.dart';

class SkyScrapperSearchProvider extends ChangeNotifier{
  String search = '';

  void changeCategory(String img){
    search = img;
    isVisible = true;
    notifyListeners();
  }

  Future<SkyScrapperModal?> fromMap(String img) async {
    final data = await SkyScrapperApiHelper.apiHelper.fetchApiData(img);
    var skyScrapperModalModal = SkyScrapperModal.fromJson(data);
    return skyScrapperModalModal;
  }
}