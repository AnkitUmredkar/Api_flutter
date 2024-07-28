import 'package:api_flutter/E-Commerce%20Api/Model/e_commerceModel.dart';
import 'package:api_flutter/E-Commerce%20Api/Provider/e_commerceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartPage.dart';
import 'detailsPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ECommerceProvider eCommerceProviderFalse =
        Provider.of<ECommerceProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0A0F22),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: FutureBuilder(
            future: eCommerceProviderFalse.fromMap(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ECommerceModel? em = snapshot.data;
                print('Success');
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: width * 0.07,
                                    backgroundImage:
                                        AssetImage('assets/images/me.jpg'),
                                  ),
                                  SizedBox(width: 7),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ankit Umredkar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        'Welcome User 👋',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: width * 0.03),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: width * 0.07,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 25,
                              ),
                              suffixIcon: Icon(
                                Icons.tune,
                                color: Colors.grey,
                                size: 25,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  )),
                              hintText: 'Search Product...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.19),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: em!.products.length,
                        itemBuilder: (context, int index) => Padding(
                          padding: EdgeInsets.fromLTRB(
                              (index % 2 == 1) ? width * 0.0135 : 0,
                              0,
                              (index % 2 == 0) ? width * 0.0135 : 0,
                              0),
                          child: GestureDetector(
                            onTap: () {
                              selectedEIndex = index;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                        em: em,
                                      )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height * 0.24,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xff1B2235),
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              em.products[index].images[0]))),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ' ${em.products[index].title}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.037),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ' ${em.products[index].category}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.035),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star_half,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          ' ${em.products[index].rating} '
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.038),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  ' ₹ ${em.products[index].price} /-'
                                      .toString(),
                                  style: TextStyle(
                                      color: Color(0xfff22f05),
                                      fontSize: width * 0.038),
                                ),
                              ],
                            ),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 16,
                        ),
                      ),
                    ),
                  ],
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
// Column(
//                     children: List.generate(
//                         em!.products.length,
//                         (index) => GestureDetector(
//                               onTap: () {
//                                 selectedEIndex = index;
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductDetailsPage(
//                                         // em: em,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xff35383F),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade500,
//                                       blurRadius: 6,
//                                     )
//                                   ],
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: height * 0.4,
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(10),
//                                             topRight: Radius.circular(10)),
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: NetworkImage(
//                                               em.products[index].images[0]),
//                                         ),
//                                       ),
//                                       // child: Text(em.products[index].),
//                                     ),
//                                     // Padding(
//                                     //   padding: const EdgeInsets.all(10),
//                                     //   child: Row(
//                                     //     mainAxisAlignment:
//                                     //         MainAxisAlignment.spaceBetween,
//                                     //     children: [
//                                     //       Column(
//                                     //         crossAxisAlignment:
//                                     //             CrossAxisAlignment.start,
//                                     //         children: [
//                                     //           Text(
//                                     //             'Id : ${em.products[index].title}',
//                                     //             style: const TextStyle(
//                                     //                 color: Colors.white),
//                                     //           ),
//                                     //           Text(
//                                     //             'name : ${em.products[index].brand}',
//                                     //             style: const TextStyle(
//                                     //                 color: Colors.white),
//                                     //           ),
//                                     //         ],
//                                     //       ),
//                                     //       Column(
//                                     //         crossAxisAlignment:
//                                     //             CrossAxisAlignment.end,
//                                     //         children: [
//                                     //           Text(
//                                     //               '  ${em.products[index].id.toString()}',
//                                     //               style: const TextStyle(
//                                     //                   color: Colors.white)),
//                                     //           const SizedBox(height: 5),
//                                     //           Text(
//                                     //               '${em.products[index].brand}',
//                                     //               style: const TextStyle(
//                                     //                   color: Colors.white)),
//                                     //         ],
//                                     //       ),
//                                     //     ],
//                                     //   ),
//                                     // )
//                                   ],
//                                 ),
//                               ),
//                             )),
//                   )

int selectedEIndex = 0;
