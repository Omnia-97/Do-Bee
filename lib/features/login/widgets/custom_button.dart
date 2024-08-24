import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              Color(0xFFAB62FF),
              Color(0xFF4A28FF),
            ],
          ),
        ),
        width: 350.w,
        height: 51.h,
        child: Text(
          buttonText,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: provider.changeLoginScaffoldColor(),
          ),
        ),
      ),
    );
  }
}
