import 'package:flutter/material.dart';
import 'package:flutter_task_app/screens/completed_task_screen.dart';
import 'package:flutter_task_app/screens/favorited_task_screen.dart';
import 'package:flutter_task_app/screens/pending_task_screen.dart';

import 'add_task_screen.dart';
import 'drawer_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  static const id = 'navbar_screen';
  const BottomNavbarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _navbarOption = <Widget>[
    const PendingTaskScreen(),
    const CompletedTaskScreen(),
    const FavoritedTaskScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (builder) {
            return const SingleChildScrollView(
              child: AddTaskScreen(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks App'),
          actions: [
            IconButton(
                onPressed: () {
                  _showBottomSheet();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const DrawerScreen(),
        body: _navbarOption[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse),
              label: 'Pending Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Completed Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorited Task',
            ),
          ],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  _showBottomSheet();
                },
              )
            : null);
  }
}
