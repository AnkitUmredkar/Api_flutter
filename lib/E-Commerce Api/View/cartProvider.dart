import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cartPage.dart';

class CartProvider extends ChangeNotifier {
  void minusQuantity(int index) {
    if (cartList[index]['qty'] > 1) {
      cartList[index]['qty']--;
      Amount = (Amount - cartList[index]['prise']).toDouble();
      notifyListeners();
    }
  }

  void addQuantity(int index) {
    cartList[index]['qty']++;
    Amount = (Amount + cartList[index]['prise']).toDouble();
    notifyListeners();
  }

  void removeProductFromCart(int index) {
    Amount = Amount - (cartList[index]['prise'] * cartList[index]['qty']);
    Amount = double.parse((Amount).toStringAsFixed(2));
    if (Amount.abs() < 0.01) {
      Amount = 0.00;
    }
    cartList.removeAt(index);
    // count[index] = 1;
    notifyListeners();
    Fluttertoast.showToast(
      msg: 'Product Remove From Cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
