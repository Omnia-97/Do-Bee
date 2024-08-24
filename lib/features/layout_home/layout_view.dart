import 'package:DooBee/features/layout_home/widgets/add_task_bottom_sheet.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


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
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: provider.changeCardColor(),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const AddTaskBottomSheet(),
                );
              });
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
        height: 88.h,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.w,
            color:const Color(0xFFD1D1D6).withOpacity(0.5)
          )
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
            currentIndex: provider.currentIndex,
            onTap: provider.changeCurrentIndex,
            items:  [
              BottomNavigationBarItem(

                
                  icon: Image(image: AssetImage(    provider.currentIndex == 0
                      ? "assets/images/selected_ic_home.png"
                      : "assets/images/ic_home.png",),width: 32.w,height:32.h ,),
                  label: 'Tasks'),
          /*    BottomNavigationBarItem(
                  icon: Icon(
                    Icons.format_list_bulleted,
                  ),
                  label: 'Tasks'),*/
              BottomNavigationBarItem(
                  icon: Image(image: AssetImage(    provider.currentIndex == 1
                      ? "assets/images/ic_user_selected.png"
                      : "assets/images/ic_user.png",),width: 32.w,height:32.h ,),
                  label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
