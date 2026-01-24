import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/service/api_service.dart';
import 'package:store_book/features/searsh/data/repo/search_repo_implementation.dart';
import 'package:store_book/features/searsh/view/widget/search_screen_body.dart';
import 'package:store_book/features/searsh/view_model/cubit/get_categorie_cubit.dart';
import 'package:store_book/features/searsh/view_model/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetCategoryCubit(
              SearchRepoImplementation(apiService: ApiService(dio: Dio())),
            ),
          ),
          BlocProvider(create: (context) =>SearchCubit(
            SearchRepoImplementation(apiService: ApiService(dio: Dio()))
          )),
        ],
        child: SearchScreenBody(),
      ),
    );
  }
}
