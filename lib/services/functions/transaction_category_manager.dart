import 'package:expense_tracker/services/models/category.dart';

class TransactionCategoryManager {
  static List<Category> expenseCategories = [];
  static List<Category> incomeCategories = [];

  static void addIncomeCategory(Category category) {
    incomeCategories.add(category);
  }

  static void addExpenseCategory(Category category) {
    expenseCategories.add(category);
  }

  static void removeIncomeCategory(Category category) {
    incomeCategories.remove(category);
  }

  static void removeExpenseCategory(Category category) {
    expenseCategories.remove(category);
  }

  static Category getCategoryFromId(String id) {
    for (var cate in expenseCategories) {
      if (cate.id == id) {
        return cate;
      }
    }
    for (var cate in incomeCategories) {
      if (cate.id == id) {
        return cate;
      }
    }
    return Category.empty();
  }
}
