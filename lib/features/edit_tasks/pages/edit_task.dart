import 'package:flutter/material.dart';

import '../../../core/widgets/container_appBar_widget.dart';

class EditTask extends StatelessWidget {
  static String routeName = 'Edit Task';
  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              ContainerAppBarWidget(text: 'To Do List'),

            Icon(Icons.arrow_back , color: Colors.white,),

          ],),
        ],
      ),

    );
  }
}
