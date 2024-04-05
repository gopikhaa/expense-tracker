import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/others/addCategory.dart';
import 'package:expense_tracker/services/pages/others/categoryItem.dart';

class IncomeCategory extends StatefulWidget {
  IncomeCategory({Key? key}) : super(key: key);

  @override
  _IncomeCategoryState createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {
  void _addIncomeCategory(Category category) {
    setState(() {
      TransactionCategoryManager.addIncomeCategory(category);
      FireStore().addIncomeCategoryToFireStore(category);
    });
  }

  void _editIncomeCategory(String newName, Category category) {
    setState(() {
      category.name = newName;
      FireStore().editIncomeCategoryToFireStore(newName, category);
    });
  }

  void _removeIncomeCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Confirm remove')),
        content: Text('Are you sure want to remove category?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                TransactionCategoryManager.removeIncomeCategory(category);
                FireStore().removeIncomeCategoryFromFireStore(category);
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
            children: TransactionCategoryManager.incomeCategories
                .map(
                  (e) => CategoryItem(
                    editCate: _editIncomeCategory,
                    category: e,
                    removeCategory: _removeIncomeCategory,
                  ),
                )
                .toList(),
          ),
          const Gap(10),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategory(addCategory: _addIncomeCategory),
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
