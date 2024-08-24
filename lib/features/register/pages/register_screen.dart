import 'package:DooBee/features/layout_home/layout_view.dart';
import 'package:DooBee/features/login/pages/login_screen.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_divider/text_divider.dart';

import '../../../core/widgets/custom_nav.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_textformfield.dart';
import '../../login/widgets/social_container.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'Register Screen';
  String emailPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

  String passPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  var formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appLocalization = AppLocalizations.of(context)!;
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.only(top: 78.h),
                    child: const ReturnButton(),
                  ),
                ),
                Text(
                  appLocalization.register,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontSize: 32.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  appLocalization.fillInfo,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF898989)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 38.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalization.fullName,
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
                        hintText: appLocalization.nameHint,
                        controller: fullNameController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 20.w),
                        //controller: emailController,
                        keyboardType: TextInputType.text,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return appLocalization.validateName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        appLocalization.email,
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
                        hintText: appLocalization.emailHint,
                        controller: emailController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 20.w),
                        //controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return appLocalization.validateEmail;
                          }
                          var regexp = RegExp(emailPattern);
                          if (!regexp.hasMatch(value)) {
                            return appLocalization.validateEmail2;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        appLocalization.password,
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
                        hintText: appLocalization.passwordHint,
                        controller: passwordController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 20.w),
                        isPassword: true,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return appLocalization.validatePassword;
                          }
                          var regexp = RegExp(passPattern);
                          if (!regexp.hasMatch(value)) {
                            return appLocalization.validatePassword2;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 33.h,
                      ),
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseFunctions.createUserAccount(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text,
                              onSuccess: () {
                                provider.initUser();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LayoutView.routeName, (route) => false);
                              },
                              onError: (errorMessage) {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(appLocalization.error),
                                        content: Text(errorMessage),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                                Text(appLocalization.tryAgain),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(appLocalization.cancel),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            );
                          }
                        },
                        buttonText: appLocalization.register,
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      TextDivider.horizontal(
                        text: Text(
                          appLocalization.orSignUp,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 15.sp,
                            color: const Color(0xFF898989),
                          ),
                        ),
                        thickness: 1,
                        color: const Color(0xFF898989),
                        indent: 8,
                        endIndent: 8,
                      ),
                      SizedBox(
                        height: 33.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 32.w,
                        ),
                        child: Row(
                          children: [
                            const SocialContainer(
                                imagePath: 'assets/images/ic_apple.svg'),
                            SizedBox(
                              width: 53.w,
                            ),
                            InkWell(
                              onTap: () async {
                                FirebaseFunctions.signInWithGoogle();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LayoutView.routeName, (route) => false);
                              },
                              child: const SocialContainer(
                                  imagePath: 'assets/images/ic_google.svg'),
                            ),
                            SizedBox(
                              width: 53.w,
                            ),
                            const SocialContainer(
                                imagePath: 'assets/images/ic_face.svg'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 33.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalization.haveAccount,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: provider.changeCardInactiveColor(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: GradientText(
                              appLocalization.login,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                              ),
                              colors: const [
                                Color(
                                  0xFFAB62FF,
                                ),
                                Color(
                                  0xFF4A28FF,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
