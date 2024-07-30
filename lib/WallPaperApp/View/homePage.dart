
import 'package:api_flutter/WallPaperApp/View/wallPaperList.dart';
import 'package:api_flutter/WallPaperApp/View/wallPaperSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import '../Model/skyScrapperModel.dart';
import '../Provider/skyScrapperProvider.dart';

bool isShow = false;
TextEditingController category = TextEditingController();

class SkyScrapper extends StatelessWidget {
  const SkyScrapper({super.key});

  @override
  Widget build(BuildContext context) {
    SkyScrapperProvider skyScrapperProviderTrue =
        Provider.of<SkyScrapperProvider>(context, listen: true);
    SkyScrapperProvider skyScrapperProviderFalse =
        Provider.of<SkyScrapperProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff424242),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  category = TextEditingController();
                  isVisible = false;
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const SearchPage()));
                },
                icon: Icon(
                  Icons.search,
                  size: width * 0.072,
                  color: Colors.white,
                ))
          ],
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Colors.black,
          title: const Text(
            'QHD Wallpaper',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body: FutureBuilder(
          future:
              skyScrapperProviderFalse.fromMap(skyScrapperProviderTrue.search),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              SkyScrapperModal? sm = snapshot.data;
              return GridView.builder(
                itemCount: sm!.hits.length,
                itemBuilder: (context, int index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WallPaperList(sm: sm, selectedIndex: index)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      sm!.hits[index].largeImageURL),
                                ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: width * 0.044,
                                    color: Colors.red,
                                  ),
                                  Text(' ${sm!.hits[index].likes.toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.033)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    size: width * 0.043,
                                    color: Colors.blue.shade100,
                                  ),
                                  Text(
                                      '  ${sm!.hits[index].comments.toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.033)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 8.8 / 16,
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
