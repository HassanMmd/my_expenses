import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/screens/MoneyItemsList.dart';
import 'package:my_expenses/screens/chartScreen.dart';
import 'package:my_expenses/screens/reminderList.dart';
import 'package:my_expenses/screens/searchScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> indexList = [
    MoneyItemsList(),
    SearchScreen(),
    ChartScreen(),
    ReminderList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(

            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 1),
            ],
            ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: const Color(0XFF125F61),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.black,
                  ),
                  label: 'Expenses'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pie_chart,
                    color: Colors.black,
                  ),
                  label: 'Statistics'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.alarm,
                    color: Colors.black,
                  ),
                  label: 'Reminders'),
            ],
          ),
        ),
      ),
      body: indexList.elementAt(_selectedIndex),
    );
  }
}
