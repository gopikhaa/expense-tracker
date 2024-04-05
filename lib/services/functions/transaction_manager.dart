import 'package:expense_tracker/services/models/trans.dart';

class TransactionManager {
  static List<Trans> trans = [];
  Map<DateTime, List<Trans>> groupTransactionsByDate() {
    Map<DateTime, List<Trans>> groupedTransactions = {};

    for (Trans transaction in trans) {
      DateTime dateOnly = DateTime(transaction.date.year, transaction.date.month, transaction.date.day);

      if (!groupedTransactions.containsKey(dateOnly)) {
        groupedTransactions[dateOnly] = [];
      }

      groupedTransactions[dateOnly]!.add(transaction);
    }

    return groupedTransactions;
  }

  void getTransactionsWeekly(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    DateTime currentDate = startDate.subtract(Duration(days: startDate.weekday - 1));
    DateTime endDate = currentDate.add(Duration(days: 6));

    List<Trans> weeklyTransactions = [];

    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      DateTime dateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        weeklyTransactions.addAll(groupedTransactions[dateOnly]!);
      }

      currentDate = currentDate.add(Duration(days: 1));
    }

    weeklyTrans = weeklyTransactions;
  }

  void getTransactionsMonthly(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    int currentMonth = startDate.month;
    int currentYear = startDate.year;
    DateTime startDateOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime endDateOfMonth = DateTime(currentYear, currentMonth + 1, 1).subtract(
      Duration(days: 1),
    );

    List<Trans> monthlyTransactions = [];

    for (DateTime date = startDateOfMonth;
        date.isBefore(endDateOfMonth) || date.isAtSameMomentAs(endDateOfMonth);
        date = date.add(Duration(days: 1))) {
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        monthlyTransactions.addAll(groupedTransactions[dateOnly]!);
      }
    }

    monthlyTrans = monthlyTransactions;
  }

  void getTransactionsYearly(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    int currentYear = startDate.year;
    DateTime startDateOfYear = DateTime(currentYear, 1, 1);
    DateTime endDateOfYear = DateTime(currentYear, 12, 31);

    List<Trans> yearlyTransactions = [];

    for (DateTime date = startDateOfYear;
        date.isBefore(endDateOfYear) || date.isAtSameMomentAs(endDateOfYear);
        date = date.add(Duration(days: 1))) {
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        yearlyTransactions.addAll(groupedTransactions[dateOnly]!);
      }
    }

    yearlyTrans = yearlyTransactions;
  }

  List<Trans> getTransactionsYearlyForStats(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    int currentYear = startDate.year;
    DateTime startDateOfYear = DateTime(currentYear, 1, 1);
    DateTime endDateOfYear = DateTime(currentYear, 12, 31);

    List<Trans> yearlyTransactions = [];

    for (DateTime date = startDateOfYear;
        date.isBefore(endDateOfYear) || date.isAtSameMomentAs(endDateOfYear);
        date = date.add(Duration(days: 1))) {
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        yearlyTransactions.addAll(groupedTransactions[dateOnly]!);
      }
    }
    return yearlyTransactions;
  }

  List<Trans> getTransactionsMonthlyForStats(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    int currentMonth = startDate.month;
    int currentYear = startDate.year;
    DateTime startDateOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime endDateOfMonth = DateTime(currentYear, currentMonth + 1, 1).subtract(
      Duration(days: 1),
    );

    List<Trans> monthlyTransactions = [];

    for (DateTime date = startDateOfMonth;
        date.isBefore(endDateOfMonth) || date.isAtSameMomentAs(endDateOfMonth);
        date = date.add(Duration(days: 1))) {
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        monthlyTransactions.addAll(groupedTransactions[dateOnly]!);
      }
    }
    return monthlyTransactions;
  }

  List<Trans> getTransactionsWeeklyForStats(DateTime startDate) {
    Map<DateTime, List<Trans>> groupedTransactions = groupTransactionsByDate();

    DateTime currentDate = startDate.subtract(Duration(days: startDate.weekday - 1));
    DateTime endDate = currentDate.add(Duration(days: 6));

    List<Trans> weeklyTransactions = [];

    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      DateTime dateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
      if (groupedTransactions.containsKey(dateOnly)) {
        weeklyTransactions.addAll(groupedTransactions[dateOnly]!);
      }

      currentDate = currentDate.add(Duration(days: 1));
    }
    return weeklyTransactions;
  }

  double getIncomeWeeklyCategory(DateTime startDate, String category) {
    double totalIncome = 0;

    for (Trans transaction in getTransactionsWeeklyForStats(startDate)) {
      if (transaction.type == Type.Income && transaction.category == category) {
        totalIncome += transaction.amount;
      }
    }

    return totalIncome;
  }

  double getExpenseWeeklyCategory(DateTime startDate, String category) {
    double totalExpense = 0;

    for (Trans transaction in getTransactionsWeeklyForStats(startDate)) {
      if (transaction.type == Type.Expense && transaction.category == category) {
        totalExpense += transaction.amount;
      }
    }

    return totalExpense;
  }

  double getIncomeMonthlyCategory(DateTime startDate, String category) {
    double totalIncome = 0;

    for (Trans transaction in getTransactionsMonthlyForStats(startDate)) {
      if (transaction.type == Type.Income && transaction.category == category) {
        totalIncome += transaction.amount;
      }
    }

    return totalIncome;
  }

  double getExpenseMonthlyCategory(DateTime startDate, String category) {
    double totalExpense = 0;

    for (Trans transaction in getTransactionsMonthlyForStats(startDate)) {
      if (transaction.type == Type.Expense && transaction.category == category) {
        totalExpense += transaction.amount;
      }
    }

    return totalExpense;
  }

  double getIncomeYearlyCategory(DateTime startDate, String category) {
    double totalIncome = 0;

    for (Trans transaction in getTransactionsYearlyForStats(startDate)) {
      if (transaction.type == Type.Income && transaction.category == category) {
        totalIncome += transaction.amount;
      }
    }

    return totalIncome;
  }

  double getExpenseYearlyCategory(DateTime startDate, String category) {
    double totalExpense = 0;

    for (Trans transaction in getTransactionsYearlyForStats(startDate)) {
      if (transaction.type == Type.Expense && transaction.category == category) {
        totalExpense += transaction.amount;
      }
    }

    return totalExpense;
  }

  static List<Trans> weeklyTrans = [];
  static List<Trans> monthlyTrans = [];
  static List<Trans> yearlyTrans = [];
}
