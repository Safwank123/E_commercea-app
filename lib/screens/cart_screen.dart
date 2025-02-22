import 'package:e_com_app/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        backgroundColor: Colors.blue,
        title: Text('Cart',style: TextStyle(fontWeight: FontWeight.bold))
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return Container(
                  width: double.infinity,
                  height:80,
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.network(product.image, width: 50),
                    title: Text(product.title),
                    subtitle: Text('₹${product.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,color: Colors.red),
                      onPressed: () {
                        
                        cartProvider.removeFromCart(product);
                      },
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
