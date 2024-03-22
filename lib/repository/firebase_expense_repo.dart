
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:expense_tracker/repository/models/category.dart';
import 'package:expense_tracker/repository/models/expense.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');


  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  @override
  Future<List<Category>> getCategory() async {
    try {
      final List<Category> categoryEntities = await categoryCollection
          .get()
          .then((value) => value.docs.map((e) => Category.fromDocument(e.data())).toList());

      final Map<String, Category> categoriesMap = {};

      final List<Category> categories = categoryEntities.map((entity) {
        if (!categoriesMap.containsKey(entity.categoryId)) {
          categoriesMap[entity.categoryId] = Category(
            totalExpenses: entity.totalExpenses,
            categoryId: entity.categoryId,
            name: entity.name,
            icon: entity.icon,
            color: entity.color,
          );
        }
        return categoriesMap[entity.categoryId]!;
      }).toList();

      return categories;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  // @override
  // Future<List<Category>> getCategory() async {
  //   try {
  //     return await categoryCollection
  //         .get()
  //         .then((value) => value.docs.map((e) =>
  //         Category.fromEntity(CategoryEntity.fromDocument(e.data()))
  //     ).toList());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      final List<Expense> expenseEntities = await expenseCollection
          .get()
          .then((value) => value.docs.map((e) => Expense.fromDocument(e.data())).toList());

      final Map<String, Category> categoriesMap = {};

      final List<Expense> expenses = expenseEntities.map((entity) {
        if (!categoriesMap.containsKey(entity.category.categoryId)) {
          categoriesMap[entity.category.categoryId] = entity.category;
        }
        return Expense(
          expenseId: entity.expenseId,
          category: categoriesMap[entity.category.categoryId]!,
          date: entity.date,
          amount: entity.amount,
        );
      }).toList();

      return expenses;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


// @override
  // Future<List<Expense>> getExpenses() async {
  //   try {
  //     return await expenseCollection
  //         .get()
  //         .then((value) => value.docs.map((e) =>
  //         Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
  //     ).toList());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

}
