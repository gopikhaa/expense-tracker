import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/functions/transaction_manager.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/models/trans.dart';

class FireStore {
  String? getUserId() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> addTransactionToFireStore(Trans tran) async {
    final userId = getUserId();

    CollectionReference transactionsCollection =
        FirebaseFirestore.instance.collection('users/$userId/transactions');
    await transactionsCollection.doc(tran.id).set({
      'note': tran.note,
      'amount': tran.amount,
      'date': tran.date,
      'id': tran.id,
      'category': tran.category,
      'acc1': tran.accId,
      'acc2': tran.acc2Id,
      'type': tran.type.toString(),
    });
  }

  Future<void> removeTransactionToFireStore(var tran) async {
    final userId = getUserId();

    CollectionReference transactionsCollection =
        FirebaseFirestore.instance.collection('users/$userId/transactions');
    await transactionsCollection.doc(tran.id).delete();
  }

  Future<void> addIncomeCategoryToFireStore(Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');

    await categoryCollection.doc('income').set(
      {
        category.id: category.name,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> addExpenseCategoryToFireStore(Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');

    await categoryCollection.doc('expense').set(
      {
        category.id: category.name,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeIncomeCategoryFromFireStore(Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');
    await categoryCollection.doc('income').update({
      category.id: FieldValue.delete(),
    });
  }

  Future<void> removeExpenseCategoryFromFireStore(Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');
    await categoryCollection.doc('expense').update({
      category.id: FieldValue.delete(),
    });
  }

  Future<void> addAccountToFireStore(Account acc) async {
    final userId = getUserId();

    CollectionReference transactionsCollection =
        FirebaseFirestore.instance.collection('users/$userId/accounts');
    await transactionsCollection.doc(acc.id).set({
      'amount': acc.amount,
      'id': acc.id,
      'name': acc.name,
    });
  }

  Future<void> removeAccountToFireStore(var acc) async {
    final userId = getUserId();
    CollectionReference accountCollection =
        FirebaseFirestore.instance.collection('/users/$userId/accounts');
    await accountCollection.doc(acc.id).delete();
  }

  Future<void> editAccountToFireStore(
      var acc, var newName, var newAmount) async {
    final userId = getUserId();
    CollectionReference accountCollection =
        FirebaseFirestore.instance.collection('users/$userId/accounts');
    await accountCollection.doc(acc.id).update({
      'amount': newAmount,
      'name': newName,
    });
  }

  Future<void> editIncomeCategoryToFireStore(
      var newName, Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');
    await categoryCollection.doc('income').update({
      category.id: newName,
    });
  }

  Future<void> editExpenseCategoryToFireStore(
      var newName, Category category) async {
    final userId = getUserId();
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('users/$userId/category');
    await categoryCollection.doc('expense').update({
      category.id: newName,
    });
  }

  Future<void> editTransactionToFireStore(
      Trans transfer,
      var newAccId,
      var newAcc2Id,
      var newAmount,
      var newCategory,
      var newNote,
      var newDate) async {
    final userId = getUserId();
    CollectionReference transferCollection =
        FirebaseFirestore.instance.collection('/users/$userId/transactions');
    await transferCollection.doc(transfer.id).update({
      'note': newNote,
      'amount': newAmount,
      'date': newDate,
      'category': newCategory,
      'acc1': newAccId,
      'acc2': newAcc2Id,
    });
  }

  Future<void> fetchAllTransactionsFromFireStore(var userId) async {
    TransactionManager.trans.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users/$userId/transactions')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in snapshot.docs) {
      Map<String, dynamic> data = document.data();
      Trans tran = Trans.old(
        accId: data['acc1'],
        amount: data['amount'],
        note: data['note'],
        date: data['date'].toDate(),
        type: Type.values.firstWhere(
          (type) => type.toString() == data['type'],
        ),
        category: data['category'],
        id: data['id'],
      );
      tran.acc2Id = data['acc2'];
      TransactionManager.trans.add(tran);
    }
  }

  Future<void> fetchAllDataFromFireStore(var userId) async {
    AccountManager.accounts.clear();

    QuerySnapshot<Map<String, dynamic>> snapshot2 = await FirebaseFirestore
        .instance
        .collection('users/$userId/accounts')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in snapshot2.docs) {
      Map<String, dynamic> data = document.data();
      Account acc = Account.old(
        name: data['name'],
        amount: data['amount'],
        id: data['id'],
      );
      AccountManager.accounts.add(acc);
    }
    TransactionCategoryManager.incomeCategories.clear();
    TransactionCategoryManager.expenseCategories.clear();

    DocumentSnapshot<Map<String, dynamic>> snapshotIncomeCate =
        await FirebaseFirestore.instance
            .collection('users/$userId/category')
            .doc('income')
            .get();
    Map<String, dynamic>? incomeCategoryData = snapshotIncomeCate.data();

    if (incomeCategoryData != null) {
      for (var data in incomeCategoryData.entries) {
        var id = data.key;
        var name = data.value.toString();
        TransactionCategoryManager.addIncomeCategory(
          Category.old(
            name: name,
            id: id,
          ),
        );
      }
    }

    DocumentSnapshot<Map<String, dynamic>> snapshotExpenseCate =
        await FirebaseFirestore.instance
            .collection('users/$userId/category')
            .doc('expense')
            .get();

    Map<String, dynamic>? expenseCategoryData = snapshotExpenseCate.data();

    if (expenseCategoryData != null) {
      for (var data in expenseCategoryData.entries) {
        var id = data.key;
        var name = data.value.toString();
        TransactionCategoryManager.addExpenseCategory(
          Category.old(
            name: name,
            id: id,
          ),
        );
      }
    }
  }

  void addCustomCategoryToDB() {
    List incomeCat = [
      "Salary/Wages",
      "Investment Income",
      "Side Hustle/Additional Income",
      "Pensions/Retirement"
    ];
    List expenseCat = ["Housing", "Food", "Healthcare", "Entertainment"];

    for (var element in incomeCat) {
      addIncomeCategoryToFireStore(Category(name: element));
    }

    for (var element in expenseCat) {
      addExpenseCategoryToFireStore(Category(name: element));
    }
  }

  Future<void> addDefaultCurrency(String defaultCurrency) async {
    try {
      // Get the current user's ID
      final userId = getUserId();

      // Get reference to Firebase Database
      CollectionReference transferCollection =
          FirebaseFirestore.instance.collection('/users/$userId/default');

      // Set the value at the specified path
      await transferCollection.doc().set({"c_key": defaultCurrency});

      print("Data added to Firebase successfully!");
    } catch (e) {
      print("Error adding data to Firebase: $e");
    }
  }
}
