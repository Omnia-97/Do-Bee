import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFDDDDDD),
          width: 1.w,
        ),
      ),
      child: SvgPicture.asset(imagePath),

    );
  }
}
