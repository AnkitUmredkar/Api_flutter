import 'package:api_flutter/E-Commerce%20Api/View/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/e_commerceProvider.dart';
import 'detailsPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0A0F22),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff0A0F22),
        ),
        body: Consumer<CartProvider>(
          builder: (BuildContext context, CartProvider value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            cartList.length,
                            (index) => Container(
                                  height: height * 0.192,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(width * 0.025),
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      //todo -----------------------------------> img
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: const Color(0xFF1B2235),
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(
                                                      cartList[index]['img']))),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.018),
                                      //todo -----------------------------------> product Details
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width * 0.48,
                                              child: Text(
                                                cartList[index]['name'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.04),
                                              ),
                                            ),
                                            Text(
                                              '₹ ${cartList[index]['prise']}/-',
                                              style: TextStyle(
                                                  color: Color(0xfff22f05),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * 0.04),
                                            ),
                                            //todo -----------------------------------> qty add or minus
                                            Padding(
                                              padding: EdgeInsets.only(left: width * 0.012),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartProvider
                                                          .minusQuantity(index);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(5.7),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color:
                                                              Color(0xff161d2f)),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.041,),
                                                  Text(
                                                    '${cartList[index]['qty']}',
                                                    style: TextStyle(
                                                      fontSize: width * 0.038,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(width: width * 0.041,),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartProvider
                                                          .addQuantity(index);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(5.7),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color:
                                                              Color(0xffef3004)),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            cartProvider
                                                .removeProductFromCart(index);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xfff22f05),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(15),
                    width: width,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 20),
                          ),
                          Text(
                            '₹ ${Amount.toStringAsFixed(2)}/-',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

double Amount = 0;
List cartList = [];
