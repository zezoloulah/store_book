import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_book/core/service/api_service.dart';

import 'package:store_book/features/home/data/repo/add_to_cart/add_to_cart_repo_implementation.dart';
import 'package:store_book/features/home/data/repo/product_repo/home_product_repo_implementation.dart';
import 'package:store_book/features/home/data/repo/slider_repo/home_slider_repo_implementation.dart';
import 'package:store_book/features/home/view/widget/home_body_screen.dart';
import 'package:store_book/features/home/view_model/add_cart/cubit/add_to_cart_cubit.dart';
import 'package:store_book/features/home/view_model/products/cubit/products_cubit.dart';
import 'package:store_book/features/home/view_model/slider/cubit/slider_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SliderCubit(
            HomeSliderRepoImplementation(apiService: ApiService(dio: Dio())),
          ),
        ),
        BlocProvider(create: (context) =>  ProductsCubit(
            HomeProductRepoImplementation(apiService: ApiService(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(
            AddToCartRepoImplementation(apiService: ApiService(dio: Dio())),
          ),
        ),
      ],
      child: HomeBodyScreen(),
    );
  }
}
