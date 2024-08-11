import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/tabs/settings/settings_tab.dart';
import 'package:todo3/tabs/task/add_task_bottom_sheet.dart';
import 'package:todo3/tabs/task/task_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    TaskTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AppTheme.white,
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon_list.png'),
                ),
                label: 'Task'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon_settings.png'),
                ),
                label: 'Settings'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (_) => AddTaskBottomSheet());
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
