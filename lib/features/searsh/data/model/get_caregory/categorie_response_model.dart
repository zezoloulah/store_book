import 'package:store_book/features/searsh/data/model/get_caregory/data_model.dart';

class CategoriesResponseModel {
  final CategoriesDataModel data;
  final String message;
  final List error;
  final int status;

  CategoriesResponseModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoriesResponseModel(
      data: CategoriesDataModel.fromJson(json['data']),
      message: json['message'],
      error: json['error'],
      status: json['status'],
    );
  }
}
