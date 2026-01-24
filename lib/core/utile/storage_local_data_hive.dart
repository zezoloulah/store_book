import 'package:hive/hive.dart';
part 'storage_local_data_hive.g.dart';
@HiveType(typeId:0)
class Book extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String price;

  Book({required this.name, required this.image, required this.price});

  
}
