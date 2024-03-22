import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/repository/models/category.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  Expense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
  );

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toDocument(),
      'date': date,
      'amount': amount,
    };
  }

  static Expense fromDocument(Map<String, dynamic> doc) {
    return Expense(
      expenseId: doc['expenseId'],
      category: Category.fromDocument(doc['category']),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'],
    );
  }
}
