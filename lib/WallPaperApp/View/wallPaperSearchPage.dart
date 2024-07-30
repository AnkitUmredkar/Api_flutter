
import 'package:api_flutter/WallPaperApp/View/wallPaperList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import '../../Pixabay Api/View/homePage.dart';
import '../Model/skyScrapperModel.dart';
import '../Provider/skyScrapperSearchProvider.dart';

bool isVisible = false;

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    SkyScrapperSearchProvider skyScrapperSearchProviderFalse =
        Provider.of<SkyScrapperSearchProvider>(context, listen: false);
    SkyScrapperSearchProvider skyScrapperSearchProviderTrue =
        Provider.of<SkyScrapperSearchProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff424242),
        appBar: AppBar(
          toolbarHeight: 70,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          centerTitle: true,
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.black,
        ),
        body: Consumer<SkyScrapperSearchProvider>(builder:
            (BuildContext context, SkyScrapperSearchProvider value,
                Widget? child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                child: TextField(
                  cursorColor: Colors.white70,
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    skyScrapperSearchProviderFalse.changeCategory(value);
                  },
                  controller: category,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search Category here...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(width: 1.8, color: Colors.white70),
                    ),
                  ),
                ),
              ),
              (isVisible)
                  ? FutureBuilder(
                      future: skyScrapperSearchProviderFalse
                          .fromMap(skyScrapperSearchProviderTrue.search),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          SkyScrapperModal? sm = snapshot.data;
                          return Expanded(
                            child: GridView.builder(
                              itemCount: sm!.hits.length,
                              itemBuilder: (context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WallPaperList(sm: sm, selectedIndex: index),));
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(sm.hits[index].largeImageURL),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.favorite,
                                                  size: width * 0.044,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                    ' ${sm.hits[index].likes.toString()}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            width * 0.033)),
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
                                                        fontSize:
                                                            width * 0.033)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 8.8 / 16,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                              padding: EdgeInsets.only(top: height * 0.25),
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  : SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
