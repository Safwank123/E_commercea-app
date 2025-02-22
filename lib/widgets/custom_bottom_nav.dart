import 'package:e_com_app/provider/bottom_nav_provider.dart/bottom_nav_provider.dart';
import 'package:e_com_app/screens/account_screen.dart';
import 'package:e_com_app/screens/cart_screen.dart';
import 'package:e_com_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -1), // Subtle shadow above the bar
          ),
        ],
      ),
      height: 90,
      child: GNav(
        rippleColor: Colors.grey.shade300, // Softer ripple effect
        hoverColor: Colors.blue.shade50, // Subtle hover color
        haptic: true, // Enable haptic feedback
        tabBorderRadius: 20, // Rounded tabs for a modern look
        tabActiveBorder: Border.all(color: Colors.blue, width: 1.5), // Active tab border
        tabBorder: Border.all(color: Colors.grey.shade300, width: 1), // Default tab border
        tabShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
          ),
        ], // Elegant shadow effect
        curve: Curves.easeInOutCubic, // Smooth animation curves
        duration: const Duration(milliseconds: 600), // Faster animation duration
        gap: 10, // Space between icon and text
        color: Colors.grey.shade600, // Unselected icon color
        activeColor: Colors.blue.shade700, // Selected icon and text color
        iconSize: 26, // Larger icon size for better visibility
        tabBackgroundColor: Colors.blue.shade100.withOpacity(0.4), // Subtle background color for active tab
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // More padding for tabs
        selectedIndex: bottomNavProvider.selectedIndex,
        
        onTabChange: (index) {
          bottomNavProvider.setSelectedIndex(index); // Update selected index
          _navigateToTab(index, context); // Navigate to corresponding screen
        },
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite_rounded,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.search_rounded,
            text: 'Search',
          ),
          GButton(
            icon: Icons.person_rounded,
            text: 'Profile',
          ),
        ],
      ),
    );
  }

  void _navigateToTab(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CartPage()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CartPage()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
      default:
        break;
    }
  }
}
