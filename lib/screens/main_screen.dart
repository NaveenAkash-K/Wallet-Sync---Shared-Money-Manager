import 'package:flutter/material.dart';
import 'package:walletSync/screens/shared_expense_screen.dart';
import 'package:walletSync/screens/trans_screen.dart';
import 'package:icons_flutter/icons_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPageIndex = 0;
  Widget _activePage = TransScreen();

  @override
  Widget build(BuildContext context) {
    if (_selectedPageIndex == 1) {
      setState(() {
        _activePage = const SharedExpenseScreen();
      });
    }
    return Scaffold(
      body: _activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
            _selectedPageIndex == 0
                ? _activePage = TransScreen()
                : _activePage = const SharedExpenseScreen();
          });
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.swap_horizontal_bold),
              label: 'Personal Expense'),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.account_group),
            label: 'Shared Expenses',
          ),
        ],
      ),
    );
  }
}
