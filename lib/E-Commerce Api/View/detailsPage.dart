import 'package:api_flutter/E-Commerce%20Api/View/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../Model/e_commerceModel.dart';
import 'cartPage.dart';


class ProductDetailsPage extends StatelessWidget {
  ECommerceModel? em;

  ProductDetailsPage({super.key, required this.em});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B2235),
        body: Column(
          children: [
            SizedBox(
              height: height * 0.428,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(6.5),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Center(
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.04),
                        child: Image.network(
                            em!.products[selectedEIndex].images[0]),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                width: width,
                decoration: const BoxDecoration(
                    color: Color(0xff0A0F22),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        em!.products[selectedEIndex].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.042),
                      ),
                      SizedBox(height: height * 0.0072),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹ ${em!.products[selectedEIndex].price} /-',
                            style: TextStyle(
                                fontSize: width * 0.04,
                                color: const Color(0xffF13005)),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              Text(
                                '  ${em!.products[selectedEIndex].rating} '
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.038),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 0.0072),
                        child: const Divider(
                          thickness: 0.3,
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.042),
                      ),
                      ReadMoreText(
                        em!.products[selectedEIndex].description,
                        style: TextStyle(
                          fontSize: width * 0.0375,
                          color: Colors.white70,
                        ),
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        moreStyle: const TextStyle(color: Colors.blue),
                        trimExpandedText: ' Show less',
                        lessStyle: const TextStyle(color: Colors.blue),
                      ),
                      SizedBox(height: height * 0.0074),
                      Text(
                        'WarrantyInformation',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.041),
                      ),
                      Text(
                        '${em!.products[selectedEIndex].warrantyInformation} (${em!.products[selectedEIndex].shippingInformation})',
                        style: TextStyle(
                            color: Colors.white70, fontSize: width * 0.038),
                      ),
                      SizedBox(height: height * 0.0075),
                      Text(
                        'Return policy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.041),
                      ),
                      Text(
                        em!.products[selectedEIndex].returnPolicy,
                        style: TextStyle(
                            color: Colors.white70, fontSize: width * 0.038),
                      ),
                      SizedBox(height: height * 0.018),
                      GestureDetector(
                        onTap: () {
                          bool check = false;
                          for (int i = 0; i < cartList.length; i++) {
                            if (cartList[i]['name'] ==
                                em!.products[selectedEIndex].title) {
                              check = true;
                            }
                          }
                          if (!check) {
                            // cartProvider.addToCart(em);
                            cartList.add({
                              'img': em!.products[selectedEIndex].images[0],
                              'name': em!.products[selectedEIndex].title,
                              'prise': em!.products[selectedEIndex].price,
                              'qty': 1
                            });
                            Amount =
                                (Amount + em!.products[selectedEIndex].price)
                                    .toDouble();
                            Fluttertoast.showToast(
                              msg: 'The product has been added to the cart',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'The product is already added',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16,
                            );
                          }
                        },
                        child: Container(
                          height: height * 0.077,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffF13005)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              ),
                              Text(
                                '  Add to Cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.042),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
