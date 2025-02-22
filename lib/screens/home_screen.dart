import 'package:e_com_app/provider/bottom_nav_provider.dart/bottom_nav_provider.dart';
import 'package:e_com_app/provider/category_provider.dart';
import 'package:e_com_app/provider/product_provider.dart';
import 'package:e_com_app/screens/cart_screen.dart';
import 'package:e_com_app/screens/single_product_screen.dart';
import 'package:e_com_app/widgets/custom_bottom_nav.dart';
import 'package:e_com_app/widgets/product_grid.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch products initially
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safely access the BottomNavProvider here
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: Text(
          'Hotpot ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
        backgroundColor: Colors.blue.shade800,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildCategories(),
          ),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          // Fetch products when category changes
          if (categoryProvider.selectedCategory.isNotEmpty) {
            Provider.of<ProductProvider>(context, listen: false)
                .fetchProductsForCategory(categoryProvider.selectedCategory);
          }

          return Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (productProvider.errorMessage.isNotEmpty) {
                return Center(child: Text('Error: ${productProvider.errorMessage}'));
              } else if (productProvider.products.isEmpty) {
                return Center(child: Text('No products found.'));
              } else {
                return ProductGridWidget(
                  onAddToCart: (product) {
                    // Handle adding product to cart
                  },
                  onProductTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProductScreen(productId: product.id.toString()),
                      ),
                    );
                  },
                  products: productProvider.products,
                );
              }
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _categoryItem('Electronics', Icons.electrical_services),
          _categoryItem('Jewelery', Icons.diamond),
          _categoryItem('Mens clothing', Icons.boy_outlined),
          _categoryItem('Womens clothing', Icons.woman),
        ],
      ),
    );
  }

  Widget _categoryItem(String category, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Select category and trigger product fetch
          Provider.of<CategoryProvider>(context, listen: false).selectCategory(category.toLowerCase());
        },
        child: Chip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.blue.shade800),
              SizedBox(width: 5),
              Text(category),
            ],
          ),
          backgroundColor: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
