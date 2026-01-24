import 'package:flutter/material.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/features/searsh/view/search_screen.dart';
import 'package:svg_flutter/svg.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                SvgPicture.asset("assets/image/book.svg", height: 20),
                SizedBox(width: h * 0.01),
                CustomText(title: "Bookia", hight: 0.022, color: Colors.black),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
