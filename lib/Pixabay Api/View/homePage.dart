import 'package:api_flutter/Pixabay%20Api/Model/pixabayModal.dart';
import 'package:api_flutter/Pixabay%20Api/Provider/pixabayProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextEditingController category = TextEditingController();

class PixabayData extends StatelessWidget {
  const PixabayData({super.key});

  @override
  Widget build(BuildContext context) {
    PixabayProvider pixabayProviderTrue =
        Provider.of<PixabayProvider>(context, listen: true);
    PixabayProvider pixabayProviderFalse =
        Provider.of<PixabayProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.blue.shade600,
          title: const Text('Calling Pixabay API',style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10,15,10,10),
          child: FutureBuilder(
            future: pixabayProviderFalse.fromMap(pixabayProviderTrue.search),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PixabayModal? pm = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (value) {
                          pixabayProviderFalse.changeCategory(value);
                        },
                        controller: category,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                pixabayProviderFalse
                                    .changeCategory(category.text);
                              },
                              icon: Icon(Icons.search),
                            ),
                            hintText: 'Search Category here',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 1.5))),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                          pm!.hits.length,
                          (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 235,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                pm.hits[index].webformatURL),
                                          )),
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
                                                  'User : ${pm.hits[index].user}'),
                                              Text(
                                                  'Views : ${pm.hits[index].views}'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.favorite),
                                                  Text(
                                                      '  ${pm.hits[index].likes.toString()}'),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.comment),
                                                  Text(
                                                      '  ${pm.hits[index].comments.toString()}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                    ],
                  ),
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
