import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/service/local_data/save_hive.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_back_bottom.dart';
import 'package:store_book/core/utile/custom_bottom.dart';
import 'package:store_book/core/utile/storage_local_data_hive.dart';
import 'package:store_book/features/details/view_model/deitails/cubit/details_cubit.dart';
import 'package:store_book/features/details/view_model/add_to_wish_list/cubit/add_to_wish_list_cubit.dart';
import 'package:store_book/features/wish_list/view_model/cubit/get_wish_list_cubit.dart';

class DetailsScreenBody extends StatefulWidget {
  const DetailsScreenBody({super.key, required this.id});
  final int id;
  @override
  State<DetailsScreenBody> createState() => _DetailsScreenBodyState();
}

class _DetailsScreenBodyState extends State<DetailsScreenBody> {
  @override
  void initState() {
    context.read<DetailsCubit>().getAllDetails(widget.id);
    context.read<GetWishListCubit>().getData();
    super.initState();
  }

  bool isSave = false;
  bool _isAdding = false;
  bool _prevIsSave = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsFailure) {
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
          if (state is DetailsSuccess) {
            var data = state.data.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackBottom(),
                      BlocConsumer<GetWishListCubit, GetWishListState>(
                        listener: (context, state) {
                          if (state is GetWishListSuccess) {
                            final exists = state.data.data.items.any(
                              (item) => item.id == data!.id,
                            );
                            setState(() {
                              isSave = exists;
                            });
                          }
                        },
                        builder: (context, state) {
                          return BlocListener<
                            AddToWishListCubit,
                            AddToWishListState
                          >(
                            listener: (context, state) {
                              if (state is AddToWishListLoading) {
                                setState(() {
                                  _isAdding = true;
                                });
                              } else if (state is AddToWishListSuccess) {
                                setState(() {
                                  _isAdding = false;
                                });
                                final resp = state.data;
                                // update icon based on server returned list
                                final exists = resp.data.products.any(
                                  (p) => p.id == data!.id,
                                );
                                setState(() {
                                  isSave = exists;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${resp.message}'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                // refresh wishlist to keep global state in sync
                                context.read<GetWishListCubit>().getData();
                              } else if (state is AddToWishListFailure) {
                                setState(() {
                                  _isAdding = false;
                                  isSave = _prevIsSave;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${state.errMassage}'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                // optionally refresh list
                                context.read<GetWishListCubit>().getData();
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (_isAdding) return; // prevent double taps
                                _prevIsSave = isSave;
                                // optimistic UI toggle
                                setState(() {
                                  isSave = !isSave;
                                });
                                context.read<AddToWishListCubit>().add(
                                  data!.id!,
                                );
                                SaveHive().addBook(
                                  Book(
                                    name: data.name!,
                                    image: data.image!,
                                    price: data.price!,
                                  ),
                                );
                              },
                              child: _isAdding
                                  ? SizedBox(
                                      width: h * 0.04,
                                      height: h * 0.04,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
                                      isSave
                                          ? Icons.bookmark_add_sharp
                                          : Icons.bookmark_outline_outlined,
                                      size: h * 0.04,
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.05),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image.network(
                        "${data!.image}",
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Center(
                    child: CustomText(
                      title: "${data.name}",
                      hight: 0.03,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    title: "${data.category}",
                    hight: 0.02,
                    color: AppColor.firstColor,
                  ),
                  SizedBox(height: h * 0.04),
                  Container(
                    height: h * 0.30,
                    child: CustomText(
                      title:
                          "${data.description!.substring(3, data.description!.length - 4)}",
                      hight: 0.015,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: "₹${data.price}",
                        hight: 0.04,
                        color: Colors.black,
                      ),
                      CustomBottom(
                        height: 0.06,
                        w: 0.17,
                        title: "AddToCart",
                        titleColor: AppColor.whiteColor,
                        bottomColor: const Color.fromARGB(255, 21, 21, 21),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container(
            height: h,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
