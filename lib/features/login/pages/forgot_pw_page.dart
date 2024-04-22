import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/core/config/app_theme_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app_new/features/settings_provider.dart';
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
      appBar: AppBar(
        iconTheme:  IconThemeData(
          color: provider.themeMode==ThemeMode.light?Colors.white:AppThemeManager.darkPrimaryColor,
        ),
        backgroundColor: AppThemeManager.primaryColor,
        title: Text(appLocalizations.forgetPassword,
            style: theme.textTheme.titleLarge),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              appLocalizations.resetTitle,
              style: theme.textTheme.displayMedium?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldRegister(
              hintText: appLocalizations.emailHint,
              suffixIcon: const Icon(Icons.email_rounded),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.validateEmail;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeManager.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                appLocalizations.reset,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
