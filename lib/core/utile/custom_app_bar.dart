import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_book/core/service/local_data/save_hive.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/features/auth/login_screen%20copy/view/login_Screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.addIcon = true});
  final String title;
  final bool addIcon;
  int() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.03,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: h * 0.03),
          CustomText(title: title, hight: 0.03, color: Colors.black),
          addIcon
              ? GestureDetector(
                  onTap: () async {
                    int();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false,
                    );
                    // SaveHive().closeHive();
                  },
                  child: Icon(Icons.door_back_door_outlined),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
