import 'package:DooBee/features/layout_home/layout_view.dart';
import 'package:DooBee/features/login/pages/forgot_pw_page.dart';
import 'package:DooBee/features/login/widgets/custom_textformfield.dart';
import 'package:DooBee/features/register/pages/register_screen.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:text_divider/text_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/app_theme_manager.dart';
import '../widgets/customicon_text.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login screen';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appLocalizations = AppLocalizations.of(context)!;
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        color: provider.changeLoginScaffoldColor(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 115,
          centerTitle: true,
          title: Text(
            appLocalizations.login,
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuery.height * 0.17,
                  ),
                  Text(
                    'appLocalizations.welcome',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    appLocalizations.email,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalizations.emailHint,
                    suffixIcon: Icon(
                      Icons.email_rounded,
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.grey
                          : Colors.white,
                    ),
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
                    height: 30,
                  ),
                  Text(
                    appLocalizations.password,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalizations.passwordHint,
                    isPassword: true,
                    controller: passwordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return appLocalizations.validatePassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const ForgotPasswordPage();
                            }),
                          );
                        },
                        child: Text(
                          appLocalizations.forgetPassword,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 295,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseFunctions.signInUser(
                              emailController.text, passwordController.text,
                              () {
                            provider.initUser();
                            Navigator.pushNamedAndRemoveUntil(context,
                                LayoutView.routeName, (route) => false);
                          }, (error) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(appLocalizations.error),
                                    content: Text(error),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(appLocalizations.tryAgain),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(appLocalizations.cancel),
                                      ),
                                    ],
                                  );
                                });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemeManager.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: Text(
                        appLocalizations.login,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 23),
                    child: TextDivider.horizontal(
                        text: Text(
                          appLocalizations.or,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        thickness: 1,
                        color: const Color(0xff565656),
                        indent: 8,
                        endIndent: 8),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseFunctions.signInWithGoogle();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LayoutView.routeName, (route) => false);
                    },
                    child: CustomIconText(
                        icon: Brand(Brands.google),
                        iconText: appLocalizations.gogLogin),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: CustomIconText(
                        icon: const Icon(
                          Icons.facebook,
                          color: Color(0xff1778F2),
                          size: 30,
                        ),
                        iconText: appLocalizations.faceLogin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 85,
                      right: 60,
                      top: 31,
                      bottom: 25,
                    ),
                    child: Row(
                      children: [
                        Text(
                          appLocalizations.createAccount,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: provider.themeMode == ThemeMode.light
                                  ? const Color(0xff474747)
                                  : Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            appLocalizations.register,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: provider.themeMode == ThemeMode.light
                                  ? const Color(0xff474747)
                                  : Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
