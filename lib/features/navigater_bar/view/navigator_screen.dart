import 'package:flutter/material.dart';
import 'package:store_book/features/cart/view/cart_screen.dart';

import 'package:store_book/features/home/view/home_screen.dart';
import 'package:store_book/features/profile/view/profile_scree.dart';
import 'package:store_book/features/wish_list/view/wish_list.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key,});
  
  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      WishList(),
      CartScreen(),
      ProfileScreen(
      ),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar( 
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items:[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      backgroundColor: const Color(0xffF9F9F9),
      body: screens[currentIndex],
    );
  }
}
