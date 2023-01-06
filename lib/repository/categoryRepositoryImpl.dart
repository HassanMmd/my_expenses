import 'package:my_expenses/model/category.dart';
import 'package:my_expenses/repository/categoryRepository.dart';
import 'package:my_expenses/services/dataBase.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  Database db = DataBaseHelper.database!;

  @override
  Future<int> addCategory(Category category) async {
    return await db.insert('category', category.toMap());
  }

  @override
  Future<List<Category>> getCategory() async {
    var categoryList = await db.query('category');
    var category = categoryList.map((e) => Category.fromMap(e));
    return category.toList();
  }
}
