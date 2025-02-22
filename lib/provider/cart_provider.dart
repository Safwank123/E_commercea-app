import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  get subTotalPrice => null;

  get totalPrice => null;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
//   void increaseQuantity(ProductModel product) {
//   product.quantity += 1;
//   notifyListeners();
// }

// void decreaseQuantity(ProductModel product) {
//   if (product.quantity > 1) {
//     product.quantity -= 1;
//     notifyListeners();
//   } else {
//     removeFromCart(product);
//   }
// }
void increaseQuantity(ProductModel product) {
  product.quantity += 1;
  notifyListeners();
}

void decreaseQuantity(ProductModel product) {
  if (product.quantity > 1) {
    product.quantity -= 1;
    notifyListeners();
  } else {
    removeFromCart(product);
  }
}


}
