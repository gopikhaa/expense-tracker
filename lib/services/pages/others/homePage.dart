import 'package:flutter/material.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/services/pages/tabs/accountPage.dart';
import 'package:expense_tracker/services/pages/tabs/transPage.dart';
import 'package:expense_tracker/services/pages/tabs/more.dart';
import 'package:expense_tracker/services/pages/tabs/stats.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    var userId = FireStore().getUserId();
    FireStore().fetchAllDataFromFireStore(userId);
    super.initState();
  }

  var _currentIndex = 0;

  final tabs = [
    TransPage(),
    Stats(),
    AccountPage(),
    More(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        fixedColor: Colors.deepPurple,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(LineIcons.moneyBill), label: 'Trans'),
          BottomNavigationBarItem(icon: Icon(LineIcons.pieChart), label: 'Stat'),
          BottomNavigationBarItem(icon: Icon(LineIcons.piggyBank), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(LineIcons.horizontalEllipsis), label: 'More'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
