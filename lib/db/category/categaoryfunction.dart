import 'package:chaching/models/categorymodel.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CategoryDbFunction {
  Future<List<model.Category>> getCategories();
  Future<void> insertCategory(model.Category value);
  Future<void> deleteCategory(String categoryID);

}

class CategoryDb implements CategoryDbFunction {
  CategoryDb._internal();
  static final CategoryDb instance = CategoryDb._internal();
  factory CategoryDb(){
    return instance;
  }

  // ValueNotifiers for income and expense categories
  final ValueNotifier<List<model.Category>> incomeCategoryNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<model.Category>> expenseCategoryNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(model.Category value) async {
    final box = await Hive.openBox<model.Category>('categoriesDB');
    await box.put(value.id, value);
    
    refreshUI();
  }

  @override
  Future<List<model.Category>> getCategories() async {
    final box = await Hive.openBox<model.Category>('categoriesDB');

    return box.values.toList();
  }

  // Refresh the UI by splitting categories into income and expense
  Future<void> refreshUI() async {
    final allCategories = await getCategories();

    // Clear old values
    incomeCategoryNotifier.value.clear();
    expenseCategoryNotifier.value.clear();

    // Add new categories, avoiding duplicates by ID
    await Future.forEach(allCategories, (category) async {
      if (category.type == model.Categorytype.income) {
        incomeCategoryNotifier.value.add(category);
      } else {
        expenseCategoryNotifier.value.add(category);
      }
    });

    // Notify UI listeners
    incomeCategoryNotifier.notifyListeners();
    expenseCategoryNotifier.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID) async{
    final _categoryDB =await Hive.openBox<model.Category>('categoriesDB');
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
    
}
