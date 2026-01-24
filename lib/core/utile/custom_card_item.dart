import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_alert_dilog_error.dart';
import 'package:store_book/core/utile/custom_bottom.dart';
import 'package:store_book/features/cart/view_model/cubit/get_cart_cubit.dart';
import 'package:store_book/features/cart/view_model/remove_from_cart/cubit/remove_to_cart_cubit.dart';
import 'package:store_book/features/cart/view_model/update_cart/cubit/up_date_cart_cubit.dart';
import 'package:store_book/features/home/view_model/add_cart/cubit/add_to_cart_cubit.dart';

class CustomCardItem extends StatefulWidget {
  const CustomCardItem({
    this.image,
    this.name,
    this.prise,
    super.key,
    this.addBottom = true,
    this.itemCount = 1,
    this.cartId,
    this.quantity,
  });
  final String? image;
  final String? name;
  final String? prise;
  final bool? addBottom;
  final int itemCount;
  final int? cartId;
  final int? quantity;
  @override
  State<CustomCardItem> createState() => _CustomCardItemState();
}

class _CustomCardItemState extends State<CustomCardItem> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 6), // 👈 الشادو لتحت فقط
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.network(
                height: h * 0.15,
                width: h * 0.12,
                "${widget.image}",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.04,
                  width: h * 0.24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: h * 0.2,
                        child: CustomText(
                          title: "${widget.name!}",
                          hight: 0.02,
                          color: Colors.black,
                        ),
                      ),
                      BlocConsumer<RemoveToCartCubit, RemoveToCartState>(
                        listener: (context, state) {
                          if (state is RemoveToCartFailure) {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialogError(
                                errMassage: state.errMassage,
                              ),
                            );
                            log(state.errMassage);
                          }
                          if (state is RemoveToCartSuccess) {
                            var data = state.data.message;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${data}'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 0),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<RemoveToCartCubit>().removeFromCart(
                                widget.cartId!,
                              );
                              context.read<GetCartCubit>().getCarts();
                            },
                            child: Icon(Icons.close_rounded),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                CustomText(
                  title: "₹${widget.prise}",
                  hight: 0.02,
                  color: Colors.black,
                ),
                SizedBox(height: h * 0.01),
                widget.addBottom == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 31),
                        child: BlocConsumer<AddToCartCubit, AddToCartState>(
                          listener: (context, state) {
                            if (state is AddToCartFailure) {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialogError(
                                  errMassage: state.errMassage,
                                ),
                              );
                            }
                            if (state is AddToCartSuccess) {
                              var data = state.data.message;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${data}'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 0),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomBottom(
                              onTap: () {
                                context.read<AddToCartCubit>().addToCart(
                                  widget.cartId!,
                                );
                              },
                              height: 0.05,
                              w: 0.20,
                              title: "AddToCart",
                              titleColor: AppColor.whiteColor,
                              bottomColor: AppColor.firstColor,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: h * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: h * 0.026,
                              width: h * 0.026,
                              decoration: BoxDecoration(
                                color: AppColor.grayColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    context.read<AddToCartCubit>().addToCart(
                                      widget.cartId!,
                                    );
                                  });
                                },
                                child: Center(
                                  child: Icon(Icons.add, size: h * 0.02),
                                ),
                              ),
                            ),
                            BlocConsumer<AddToCartCubit, AddToCartState>(
                              listener: (context, state) {
                                if (state is AddToCartSuccess) {
                                  var d = state.data;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${d.message}'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 0),
                                    ),
                                  );
                                  // Refresh cart data after successful update and rebuild UI
                                  context.read<GetCartCubit>().getCarts();
                                  setState(() {});
                                }
                              },
                              builder: (context, state) {
                                if (state is UpDateCartLoading) {
                                  return CircularProgressIndicator();
                                }
                                return CustomText(
                                  title: widget.quantity.toString(),
                                  hight: 0.02,
                                  color: Colors.black,
                                );
                              },
                            ),
                            Container(
                              height: h * 0.026,
                              width: h * 0.026,
                              decoration: BoxDecoration(
                                color: AppColor.grayColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (widget.quantity! > 1) {
                                      setState(() {
                                        log(widget.quantity.toString());
                                        context
                                            .read<AddToCartCubit>()
                                            .addToCart(widget.cartId!);
                                      });
                                    }
                                  },
                                  child: Icon(Icons.remove, size: h * 0.02),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
