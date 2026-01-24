import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_app_bar.dart';
import 'package:store_book/features/wish_list/view/widget/custom_list_view.dart';
import 'package:store_book/core/utile/custom_loading_List_view.dart';
import 'package:store_book/features/wish_list/view_model/cubit/get_wish_list_cubit.dart';

class WishListBody extends StatefulWidget {
  const WishListBody({super.key});

  @override
  State<WishListBody> createState() => _WishListBodyState();
}

class _WishListBodyState extends State<WishListBody> {
  @override
  void initState() {
    context.read<GetWishListCubit>().getData();
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
            SizedBox(height: h * 0.05),
            CustomAppBar(title: "WishList", addIcon: false),
            BlocBuilder<GetWishListCubit, GetWishListState>(
              builder: (context, state) {
                if (state is GetWishListLoading) {
                  return CustomLoadingListView();
                }
                if (state is GetWishListSuccess) {
                  var data = state.data.data.items;
                  return data.isEmpty? Lottie.asset(
                            'assets/animation/Empty box.json',
                          ): CustomListView(data: data);
                }
                if (state is GetWishListFailure) {
                  return Container(
                    child: Center(
                      child: CustomText(
                        title: "${state.errMassage}",
                        hight: 0.02,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return Container(
                  child:  Lottie.asset('assets/animation/Empty box.json'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
