 
import 'package:e_com_app/provider/bottom_nav_provider.dart/bottom_nav_provider.dart';
import 'package:e_com_app/provider/cart_provider.dart';
import 'package:e_com_app/provider/category_provider.dart';
import 'package:e_com_app/provider/login_provider.dart';
import 'package:e_com_app/provider/single_product_provider.dart';
import 'package:e_com_app/provider/product_provider.dart';
import 'package:e_com_app/provider/user_profile_provider.dart';
import 'package:e_com_app/screens/splash_screen.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  username: "mor_2314",
//                 password: "83r5^_"

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider(),),
       ChangeNotifierProvider(create: (context) => SingleProductProvider(),),
      ChangeNotifierProvider(create: (context) => CartProvider(),),
      ChangeNotifierProvider(create: (context) => CategoryProvider(),),
       ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) =>BottomNavProvider (),),
      
       ChangeNotifierProvider(create: (context) =>UserProfileProvider (),),
      
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotpot',
        theme: ThemeData(
          
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:SplashScreen()
    )
    );
  }
}


   