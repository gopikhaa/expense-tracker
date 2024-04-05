import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/others/addCategory.dart';
import 'package:expense_tracker/services/pages/others/categoryItem.dart';

class ExpenseCategory extends StatefulWidget {
  ExpenseCategory({Key? key}) : super(key: key);

  @override
  _ExpenseCategoryState createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  void _addExpenseCategory(Category category) {
    setState(() {
      TransactionCategoryManager.addExpenseCategory(category);
      FireStore().addExpenseCategoryToFireStore(category);
    });
  }

  void _editExpenseCategory(String newName, Category category) {
    setState(() {
      category.name = newName;
      FireStore().editExpenseCategoryToFireStore(newName, category);
    });
  }

  void _removeExpenseCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Confirm remove')),
        content: Text('Are you sure want to remove category?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                TransactionCategoryManager.removeExpenseCategory(category);
                FireStore().removeExpenseCategoryFromFireStore(category);
              });
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: TransactionCategoryManager.expenseCategories
                .map(
                  (e) => CategoryItem(
                    editCate: _editExpenseCategory,
                    category: e,
                    removeCategory: _removeExpenseCategory,
                  ),
                )
                .toList(),
          ),
          const Gap(10),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategory(addCategory: _addExpenseCategory),
              ),
            ),
            child: DottedBorder(
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              padding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
