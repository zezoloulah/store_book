import 'package:hive/hive.dart';
import 'package:store_book/core/service/local_data/local_service_sheard.dart';
import 'package:store_book/core/utile/storage_local_data_hive.dart';

class SaveHive {
  late final Box<Book> box;

  SaveHive()  {
    final email = LocalService.email ?? 'guest';
    Hive.openBox(email);
    // box = Hive.box<Book>(email);
  }

  void closeHive() async {
    final email = LocalService.email ?? 'gest';
    await Hive.box<Book>(email).close();
  }

  void addBook(Book book) {
    box.add(book);
  }

  List<Book> getBooks() {
    return box.values.toList();
  }

  void deleteBook(int index) {
    box.deleteAt(index);
  }
}
