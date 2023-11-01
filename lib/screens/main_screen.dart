import 'package:flutter/material.dart';
import 'package:walletSync/screens/analytics_screen.dart';
import 'package:walletSync/screens/shared_expense.dart';
import 'package:walletSync/screens/trans_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPageIndex = 0;
  Widget _activePage = const TransScreen();

  @override
  Widget build(BuildContext context) {
    // if (_selectedPageIndex == 1) {
    //   setState(() {
    //     _activePage = const SharedExpense();
    //   });
    // }
    return Scaffold(
      body: _activePage,
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index) {
      //     setState(() {
      //       _selectedPageIndex = index;
      //       _selectedPageIndex == 0
      //           ? _activePage = const TransScreen()
      //           : _activePage = const SharedExpense();
      //     });
      //   },
      //   currentIndex: _selectedPageIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.currency_exchange_rounded),
      //         label: 'Personal Expense'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.connect),
      //       label: 'Analytics',
      //     ),
      //   ],
      // ),
    );
  }
}
