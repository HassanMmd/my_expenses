import 'package:flutter/cupertino.dart';
import 'package:my_expenses/model/category.dart';
import 'package:my_expenses/repository/categoryRepositoryImpl.dart';
import 'package:provider/provider.dart';

class CategoryViewModel extends ChangeNotifier{

  CategoryRepositoryImpl categoryRepositoryImpl = CategoryRepositoryImpl();


  Future<int> addCategory(Category category) async{
  return await categoryRepositoryImpl.addCategory(category);
  }

  Future<List<Category>> getCategory() async{
    return await categoryRepositoryImpl.getCategory();
  }

}