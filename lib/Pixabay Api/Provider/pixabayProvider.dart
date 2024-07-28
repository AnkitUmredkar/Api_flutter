import 'package:flutter/cupertino.dart';
import '../ApiHelper/apiHelper.dart';
import '../Model/pixabayModal.dart';

class PixabayProvider extends ChangeNotifier{

  PixabayModal? pixabayModal;
  String search = '';

  void changeCategory(String img){
    search = img;
    notifyListeners();
  }

  Future<PixabayModal?> fromMap(String img) async {
    final data = await ApiHelper.apiHelper.fetchApiData(img);
    pixabayModal = PixabayModal.fromJson(data);
    return pixabayModal;
  }
}