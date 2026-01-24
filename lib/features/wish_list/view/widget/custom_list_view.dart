import 'package:flutter/material.dart';
import 'package:store_book/core/utile/custom_card_item.dart';
import 'package:store_book/features/wish_list/data/model/wish_list_model.dart';


class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.data});
  final List<WishlistItem> data;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.85,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, count) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: h * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomCardItem(
                
                image: data[count].image,
                name: data[count].name,
                prise: data[count].price.toString(),
                quantity: data[count].stock,
                cartId: data[count].id,
              ),
            ),
          );
        },
      ),
    );
  }
}
