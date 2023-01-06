import 'package:my_expenses/model/category.dart';

abstract class CategoryRepository {

Future<int> addCategory(Category category);
Future<List<Category>> getCategory();

}