import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../Model/recipesModel.dart';

class DetailsPage extends StatelessWidget {
  RecipeModal? rm;

  DetailsPage({super.key, required this.rm});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            height: height * 0.42, //350,
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(rm!.recipes[selectedIndex].image),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rm!.recipes[selectedIndex].name,
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.045)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Meal Type : ${rm!.recipes[selectedIndex].mealType.join(', ')}',
                          style: TextStyle(fontSize: width * 0.037),
                        ),
                        Text(
                          '${(rm!.recipes[selectedIndex].userId + 100).toString()} Reviews',
                          style: TextStyle(fontSize: width * 0.037),
                        ),
                      ],
                    ),
                    Text(
                      'Cuisine : ${rm!.recipes[selectedIndex].cuisine}',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.5),
                      child: Divider(
                        thickness: 1.6,
                      ),
                    ),
                    // SizedBox(height: 6),
                    Text('Description',
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.045)),
                    ReadMoreText(
                      rm!.recipes[selectedIndex].instructions.join(' '),
                      style: TextStyle(
                        fontSize: width * 0.0375,
                        color: Colors.white70,
                      ),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      moreStyle: const TextStyle(color: Colors.blue),
                      trimExpandedText: ' Show less',
                      lessStyle: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(height: 9),
                    Text('Ingredients',
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.045)),
                    Text(
                      rm!.recipes[selectedIndex].ingredients.join(', '),
                      style: TextStyle(
                          color: Colors.white70, fontSize: width * 0.0375),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₹ ${rm!.recipes[selectedIndex].userId * 12}.0 /-',
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.048),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width,
                      height: height * 0.08,
                      margin: const EdgeInsets.only(top: 9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.048),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

int selectedIndex = 0;
