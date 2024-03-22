
import 'package:expense_tracker/repository/models/category.dart';
import 'package:expense_tracker/repository/models/expense.dart';

abstract class ExpenseRepository {

  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  Future<void> createExpense(Expense expense);

  Future<List<Expense>> getExpenses();
}