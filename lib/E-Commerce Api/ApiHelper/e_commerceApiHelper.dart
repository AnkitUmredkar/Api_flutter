import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ECommerceApiHelper {
  static ECommerceApiHelper eCommerceApiHelper = ECommerceApiHelper._();

  ECommerceApiHelper._();

  Future<Map> fetchApiData() async {
    Uri url = Uri.parse("https://dummyjson.com/products");

    Response response = await http.get(url);

    if (response.statusCode == 200) {
      final json = response.body;
      final Map data = jsonDecode(json);
      return data;
    } else {
      return {};
    }
  }
}
