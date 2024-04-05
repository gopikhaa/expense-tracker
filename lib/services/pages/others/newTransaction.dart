import 'package:flutter/material.dart';
import 'package:expense_tracker/services/pages/others/newExpense.dart';
import 'package:expense_tracker/services/pages/others/newIncome.dart';
import 'package:expense_tracker/services/pages/others/newTransfer.dart';
import 'package:gap/gap.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({required this.addTrans, Key? key}) : super(key: key);
  final Function addTrans;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _controller = PageController(initialPage: 0);
  int _selectedPage = 0;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
              setState(() {
                _selectedPage = 0;
              });
            },
            child: Text(
              'Income',
              style: TextStyle(
                color: _selectedPage == 0 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                1,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
              setState(() {
                _selectedPage = 1;
              });
            },
            child: Text(
              'Expense',
              style: TextStyle(
                color: _selectedPage == 1 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                2,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
              setState(() {
                _selectedPage = 2;
              });
            },
            child: Text(
              'Transfer',
              style: TextStyle(
                color: _selectedPage == 2 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          const Gap(50),
        ],
      ),
      body: PageView(
        onPageChanged: _onPageChanged,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          NewIncome(
            addTrans: widget.addTrans,
          ),
          NewExpense(
            addTrans: widget.addTrans,
          ),
          NewTransfer(
            addTrans: widget.addTrans,
          ),
        ],
      ),
    );
  }
}
