import 'package:api_flutter/Recipe%20Api/View/detailsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/recipesModel.dart';
import '../Provider/recipeProvider.dart';

class RecipeData extends StatelessWidget {
  const RecipeData({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeProvider recipeProviderTrue =
        Provider.of<RecipeProvider>(context, listen: true);
    RecipeProvider recipeProviderFalse =
        Provider.of<RecipeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.blue.shade600,
          title: const Text(
            'Recipe App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: FutureBuilder(
            future: recipeProviderFalse.fromMap(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RecipeModal? rm = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          rm!.recipes.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  selectedIndex = index;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                            rm: rm,
                                          )));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff35383F),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 6,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 235,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                rm.recipes[index].image),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Id : ${rm.recipes[index].id}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 244,
                                                  child: Text(
                                                    'name : ${rm.recipes[index].name}',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '  ${rm.recipes[index].cuisine.toString()}',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                                const SizedBox(height: 5),
                                                Text(
                                                    '${rm.recipes[index].userId.toString()} Reviews',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
