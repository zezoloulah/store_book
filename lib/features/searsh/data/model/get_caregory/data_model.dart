import 'package:store_book/features/searsh/data/model/get_caregory/categorie_model.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/links_model.dart';
import 'package:store_book/features/searsh/data/model/get_caregory/meta_model.dart';

class CategoriesDataModel {
  final List<CategoryModel> categories;
  final MetaModel meta;
  final LinksModel links;

  CategoriesDataModel({
    required this.categories,
    required this.meta,
    required this.links,
  });

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    return CategoriesDataModel(
      categories: List<CategoryModel>.from(
        json['categories'].map((e) => CategoryModel.fromJson(e)),
      ),
      meta: MetaModel.fromJson(json['meta']),
      links: LinksModel.fromJson(json['links']),
    );
  }
}
