import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/pages/others/expense_chart.dart';
import 'package:expense_tracker/services/pages/others/income_chart.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String _selectedTime = 'Weekly';
  var format = DateFormat('d/M/yyyy (E)');
  var _selectedDate = DateTime.now();
  final _controller = PageController();
  var _selectedPage = 0;
  void _onPageChanged(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  void _pickDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 3, now.month, now.day);
    final last = DateTime(now.year + 2, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: first, lastDate: last, initialDate: now);
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _pickDate(),
            child: Text(
              format.format(_selectedDate),
            ),
          ),
          const Gap(15),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'Income',
                  style: TextStyle(
                    color:
                        _selectedPage == 0 ? Colors.black : Colors.deepPurple,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _controller.animateToPage(
                    1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'Expense',
                  style: TextStyle(
                    color:
                        _selectedPage == 1 ? Colors.black : Colors.deepPurple,
                  ),
                ),
              ),
              DropdownButton(
                items: ['Weekly', 'Monthly', 'Yearly']
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTime = newValue!;
                  });
                },
                value: _selectedTime,
              )
            ],
          ),
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: [
          IncomeChart(
            time: _selectedTime,
            date: _selectedDate,
          ),
          ExpenseChart(
            date: _selectedDate,
            time: _selectedTime,
          ),
        ],
      ),
    );
  }
}
