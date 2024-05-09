import 'package:flutter/material.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/functions/transaction_manager.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/others/inforStat.dart';
import 'package:expense_tracker/services/pages/reusable/pie_chart.dart';

class ExpenseChart extends StatelessWidget {
  ExpenseChart({Key? key, required this.time, required this.date})
      : super(key: key);
  final DateTime date;
  final String time;

  @override
  Widget build(BuildContext context) {
    double total = 0;
    Map<String, double> dataMap = {
      for (Category category in TransactionCategoryManager.expenseCategories)
        category.name: time == 'Monthly'
            ? TransactionManager().getExpenseMonthlyCategory(date, category.id)
            : time == 'Yearly'
                ? TransactionManager()
                    .getExpenseYearlyCategory(date, category.id)
                : TransactionManager()
                    .getExpenseWeeklyCategory(date, category.id),
    };
    dataMap.forEach((key, value) {
      total += value;
    });
    dataMap = {'total': total, ...dataMap};
    return TransactionCategoryManager.expenseCategories.length == 0
        ? Center(
            child: Text(
              'No category found!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Column(
            children: [
              InformationStat(
                dataMap: dataMap,
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.purple,
                  Colors.brown,
                  Color(0xFFE57373),
                  Color(0xFFF06292),
                  Color(0xFFBA68C8),
                  Color(0xFF9575CD),
                  Color(0xFF7986CB),
                  Color(0xFF64B5F6),
                  Color(0xFF4FC3F7),
                  Color(0xFF4DD0E1),
                  Color(0xFF4DB6AC),
                  Color(0xFF81C784),
                  Color(0xFFAED581),
                  Color(0xFFFF8A65),
                  Color(0xFFD4E157),
                  Color(0xFFFFD54F),
                  Color(0xFFFFB74D),
                  Color(0xFFA1887F),
                  Color(0xFF90A4AE),
                  Color(0xFFB0BEC5),
                  Color(0xFF78909C),
                  Color(0xFF455A64),
                ],
              ),
              Chart(
                dataMap: dataMap,
                name: 'Test',
              ),
            ],
          );
  }
}
