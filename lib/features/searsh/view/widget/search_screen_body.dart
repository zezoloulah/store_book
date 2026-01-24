import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_back_bottom.dart';
import 'package:store_book/core/utile/custom_card_item.dart';

import 'package:store_book/core/utile/custom_loading_List_view.dart';
import 'package:store_book/core/utile/custom_text_form_field.dart';
import 'package:store_book/features/searsh/view_model/cubit/get_categorie_cubit.dart';
import 'package:store_book/features/searsh/view_model/search/cubit/search_cubit.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<GetCategoryCubit>().getCategory();
    super.initState();
  }

  int categoryCount = -1;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.05),
            Row(
              children: [
                CustomBackBottom(),
                SizedBox(width: h * 0.05),
                CustomText(title: "Search", hight: 0.05, color: Colors.black),
              ],
            ),
            SizedBox(height: h * 0.02),
            CustomTextFormField(
              controller: searchController,
              title: "search",
              onChange: (value) {
                searchController.text = value;
                context.read<SearchCubit>().search(value);
              },
            ),
            BlocBuilder<GetCategoryCubit, GetCategoryState>(
              builder: (context, state) {
                if (state is GetCategoryFailure) {
                  return CustomText(
                    title: "${state.errMassage}",
                    hight: 0.02,
                    color: Colors.black,
                  );
                }
                if (state is GetCategorySuccess) {
                  var data = state.data.data.categories;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "categories",
                        hight: 0.02,
                        color: Colors.black,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: h * 0.05,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, count) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: GestureDetector(
                                  onTap: () {
                                    searchController.text = data[count].name;
                                    context.read<SearchCubit>().search(
                                      searchController.text,
                                    );
                                    setState(() {
                                      categoryCount = count;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(20),
                                      color: categoryCount == count
                                          ? AppColor.firstColor
                                          : AppColor.grayColor,
                                    ),
                                    height: h * 0.01,
                                    width: h * 0.2,
                                    child: Center(
                                      child: CustomText(
                                        title: "${data[count].name}",
                                        hight: 0.02,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Shimmer(
                  color: Colors.black,
                  child: Container(
                    height: h * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, count) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.grayColor,
                            ),
                            height: h * 0.01,
                            width: h * 0.2,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return CustomLoadingListView();
                }
                if (state is SearchSuccess) {
                  var data = state.data.items;
                  return SingleChildScrollView(
                    child: Container(
                      height: h * 0.65,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, count) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 6), // 👈 الشادو لتحت فقط
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: h*0.2,
                                      width: h*0.13,
                                      child: ClipRRect(
                                        borderRadius: BorderRadiusGeometry.circular(10),
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          data[count].volumeInfo.imageLinks.thumbnail)),
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Column(children: [
                                      Container(
                                        height: h*0.07,width: h*0.23,
                                        child: CustomText(title: data[count].volumeInfo.title, hight: 0.02, color: Colors.black))
                                    ],),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                if (state is SearchFailure) {
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
                  height: h * 0.5,
                  child: Lottie.asset('assets/animation/Empty box.json'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
