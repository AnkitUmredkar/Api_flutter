class RecipeModal {
  List<Recipes> recipes = [];

  RecipeModal({required this.recipes});

  factory RecipeModal.fromJson(Map m1) {
    return RecipeModal(
        recipes:
            (m1['recipes'] as List).map((e) => Recipes.fromJson(e)).toList());
  }
}

class Recipes {
  late int id, userId;
  late String name, image, cuisine;
  late List instructions = [];
  late List mealType = [];
  late List ingredients = [];

  Recipes(
      {required this.id,
      required this.userId,
      required this.name,
      required this.image,
      required this.cuisine,
      required this.instructions,
      required this.ingredients,
      required this.mealType});

  factory Recipes.fromJson(Map m1) {
    return Recipes(
        id: m1['id'],
        userId: m1['userId'],
        name: m1['name'],
        image: m1['image'],
        cuisine: m1['cuisine'],
        instructions: m1['instructions'],
        ingredients: m1['ingredients'],
        mealType: m1['mealType']);
  }
}
