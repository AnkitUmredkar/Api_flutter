import 'package:api_flutter/E-Commerce%20Api/Provider/e_commerceProvider.dart';
import 'package:api_flutter/E-Commerce%20Api/View/cartPage.dart';
import 'package:api_flutter/E-Commerce%20Api/View/cartProvider.dart';
import 'package:api_flutter/E-Commerce%20Api/View/homePage.dart';
import 'package:api_flutter/Pixabay%20Api/Provider/pixabayProvider.dart';
import 'package:api_flutter/Recipe%20Api/Provider/recipeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pixabay Api/View/homePage.dart';
import 'Recipe Api/View/showRecipe.dart';
import 'WallPaperApp/Provider/skyScrapperProvider.dart';
import 'WallPaperApp/Provider/skyScrapperSearchProvider.dart';
import 'WallPaperApp/View/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PixabayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecipeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ECommerceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SkyScrapperProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SkyScrapperSearchProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        // theme: ThemeData(
        //   brightness: Brightness.dark,
        //   primaryColor: Colors.grey.shade900,
        //   scaffoldBackgroundColor: Colors.grey.shade900,
        //   appBarTheme: AppBarTheme(
        //     backgroundColor: Colors.grey.shade900,
        //   ),
        // ),
        debugShowCheckedModeBanner: false,
        home: const WaSplashscreen(),
      ),
    );
  }
}
