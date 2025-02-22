import 'package:e_com_app/provider/single_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductScreen extends StatefulWidget {
  final String productId;

  const SingleProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      Provider.of<SingleProductProvider>(context, listen: false)
          .fetchProductById(widget.productId);
    });
  }

  void _orderProduct(BuildContext context) {
    
    final productProvider = Provider.of<SingleProductProvider>(context, listen: false);

    if (productProvider.product != null) {
      final product = productProvider.product!;

      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Order Confirmation"),
          content: Text("You have successfully ordered ${product.title} for \$${product.price}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<SingleProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Product Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.product == null
              ? Center(child: Text("No product found"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        productProvider.product!.image ?? '',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Text(
                        productProvider.product!.title ?? 'No Title Available',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 280),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          width: 60,
                          child: Center(
                            child: Text(
                              "\$${productProvider.product!.price ?? 0.0}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        productProvider.product!.description ?? 'No Description Available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Rating: ${productProvider.product!.rating?.rate ?? '0.0'} "
                        "(${productProvider.product!.rating?.count ?? '0'} reviews)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () => _orderProduct(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
