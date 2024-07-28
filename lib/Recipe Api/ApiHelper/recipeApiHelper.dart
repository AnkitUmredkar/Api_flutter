import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RecipeApiHelper {
  static RecipeApiHelper recipeApiHelper = RecipeApiHelper._();

  RecipeApiHelper._();

  Future<Map> fetchApiData() async {
    Uri url = Uri.parse("https://dummyjson.com/recipes");

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
