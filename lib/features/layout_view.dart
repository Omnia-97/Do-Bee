import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/features/settings_provider.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = 'Layout Screen';
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      body: provider.tabs[provider.currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: provider.changeCurrentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.format_list_bulleted,
                ),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
