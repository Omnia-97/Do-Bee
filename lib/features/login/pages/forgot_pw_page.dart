import 'package:DooBee/features/settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_nav.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textformfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.reset),
              content: Text(AppLocalizations.of(context)!.resetPassword),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.error),
              content: Text(e.message.toString()),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.tryAgain),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.only(top: 78.h),
                child: const ReturnButton(),
              ),
            ),
            Text(
              appLocalizations.newPassword,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontSize: 32.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              appLocalizations.diffPass,
              style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF898989)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 90.h,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                appLocalizations.email,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  color: provider.changeCardInactiveColor(),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomTextFormFieldRegister(
              hintText: appLocalizations.emailHint,
              controller: emailController,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
              //controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.validateEmail;
                }
                return null;
              },
            ),
            SizedBox(
              height: 70.h,
            ),
            CustomButton(
              onPressed: resetPassword,
              buttonText: appLocalizations.reset,
            ),
          ],
        ),
      ),
    );
  }
}
