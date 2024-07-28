import 'package:api_flutter/Recipe%20Api/ApiHelper/recipeApiHelper.dart';
import 'package:flutter/cupertino.dart';
import '../Model/recipesModel.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeModal? recipeModal;

  Future<RecipeModal?> fromMap() async {
    final data = await RecipeApiHelper.recipeApiHelper.fetchApiData();
    recipeModal = RecipeModal.fromJson(data);
    notifyListeners();
    return recipeModal;
  }
}
