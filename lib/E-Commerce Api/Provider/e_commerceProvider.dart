import 'package:api_flutter/E-Commerce%20Api/ApiHelper/e_commerceApiHelper.dart';
import 'package:flutter/cupertino.dart';
import '../Model/e_commerceModel.dart';
import '../View/cartPage.dart';
import '../View/homePage.dart';

class ECommerceProvider extends ChangeNotifier {
  ECommerceModel? eCommerceModel;

  Future<ECommerceModel?> fromMap() async {
    final data = await ECommerceApiHelper.eCommerceApiHelper.fetchApiData();
    eCommerceModel = ECommerceModel.fromJson(data);
    notifyListeners();
    return eCommerceModel;
  }
}
