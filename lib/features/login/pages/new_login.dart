import 'package:DooBee/features/login/pages/forgot_pw_page.dart';
import 'package:DooBee/features/login/widgets/custom_button.dart';
import 'package:DooBee/features/login/widgets/custom_textformfield.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_divider/text_divider.dart';

class NewLogin extends StatelessWidget {
  static const String routeName = 'new login';
  const NewLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appLocalizations = AppLocalizations.of(context)!;
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: provider.changeLoginScaffoldColor(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120.h),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                appLocalizations.login,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: provider.changeCardInactiveColor(),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              appLocalizations.welcomeBack,
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF898989),
              ),
            ),
          ),
          SizedBox(
            height: 58.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.email,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: provider.changeCardInactiveColor(),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormFieldRegister(
                  hintText: appLocalizations.emailHint,
                  contentPadding: EdgeInsets.symmetric(vertical:14.h, horizontal: 20.w),
                  //controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return appLocalizations.validateEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h,),
                Text(
                  appLocalizations.password,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: provider.changeCardInactiveColor(),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormFieldRegister(
                  hintText: appLocalizations.passwordHint,
                  contentPadding: EdgeInsets.symmetric(vertical:14.h, horizontal: 20.w),
                  isPassword: true,
                  //controller: passwordController,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return appLocalizations.validatePassword;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18.h,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const ForgotPasswordPage();
                      }),
                    );
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child:  GradientText(
                      appLocalizations.forgetPassword,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      colors: const [
                        Color(0xFFAB62FF),
                        Color(0xFF4A28FF),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 33.h,),
                CustomButton(onPressed: (){}, buttonText: appLocalizations.login),
                SizedBox(height: 29.h,),
                TextDivider.horizontal(
                    text: Text(
                      appLocalizations.or,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.sp,
                        color: const Color(0xFF898989),
                      ),
                    ),
                    thickness: 1,
                    color: const Color(0xFF898989),
                    indent: 8,
                    endIndent: 8),



              ],
            ),
          )
        ],
      ),
    );
  }
}
