import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_app_bar.dart';
import 'package:store_book/core/utile/custom_bottom.dart';
import 'package:store_book/core/utile/custom_card_item.dart';
import 'package:store_book/features/cart/view_model/cubit/get_cart_cubit.dart';
import 'package:store_book/features/check_out/view/check_out_screen.dart';

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({super.key});

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  late double total;
  @override
  void initState() {
    context.read<GetCartCubit>().getCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: h * 0.06),
            CustomAppBar(title: "My Cart", addIcon: false),
            BlocBuilder<GetCartCubit, GetCartState>(
              builder: (context, state) {
                if (state is GetCartFailure) {
                  return Container(
                    child: Center(
                      child: CustomText(
                        title: state.errMassage,
                        hight: 0.05,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                if (state is GetCartSuccess) {
                  var data = state.data.data.cartItems;
                  return data.isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'assets/animation/Empty box.json',
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: h * 0.7,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, count) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomCardItem(
                                      name: data[count].productName,
                                      prise: data[count].total.toString(),
                                      image: data[count].productImage,
                                      addBottom: false,
                                      itemCount: data[count].quantity,
                                      cartId: data[count].itemId,
                                      quantity: data[count].quantity,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "total:",
                                  hight: 0.03,
                                  color: AppColor.darkerColor,
                                ),
                                CustomText(
                                  title: "₹${state.data.data.total}",
                                  hight: 0.03,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            CustomBottom(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckOutScreen(
                                      total: state.data.data.total,
                                    ),
                                  ),
                                );
                              },
                              title: "Checkout",
                              titleColor: AppColor.whiteColor,
                              bottomColor: AppColor.firstColor,
                            ),
                          ],
                        );
                }if(state is GetCartLoading){
                  return SizedBox(
                  height: h * 0.85,
                  child: ListView.builder(
                    itemBuilder: (context, count) {
                      return Shimmer(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Container(height: h * 0.16),
                        ),
                      );
                    },
                  ),
                );
                }
                return  Center(
                          child: Lottie.asset(
                            'assets/animation/Empty box.json',
                          ),
                        );
              },
            ),
          ],
        ),
      ),
    );
  }
}
