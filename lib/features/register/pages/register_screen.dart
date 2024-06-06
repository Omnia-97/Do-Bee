import 'package:DooBee/features/layout_home/layout_view.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/app_theme_manager.dart';
import '../../login/widgets/custom_textformfield.dart';

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
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        color: provider.changeLoginContainer(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: provider.themeMode == ThemeMode.light
                ? Colors.white
                : AppThemeManager.darkPrimaryColor,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 115,
          centerTitle: true,
          title: Text(
            appLocalization.create,
            style: theme.textTheme.titleLarge,
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
                    appLocalization.fullName,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalization.nameHint,
                    suffixIcon: Icon(
                      Icons.person,
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.grey
                          : Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    controller: fullNameController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return appLocalization.validateName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    appLocalization.email,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalization.emailHint,
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
                        return appLocalization.validateEmail;
                      }
                      var regexp = RegExp(emailPattern);
                      if (!regexp.hasMatch(value)) {
                        return appLocalization.validateEmail2;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    appLocalization.password,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalization.passwordHint,
                    isPassword: true,
                    controller: passwordController,
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
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    appLocalization.confirmPassword,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: appLocalization.confirmHint,
                    isPassword: true,
                    controller: confirmPasswordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return appLocalization.validateConfirm;
                      }
                      if (value != passwordController.text) {
                        return appLocalization.validateConfirm2;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
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
                                        child: Text(appLocalization.tryAgain),
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemeManager.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalization.create,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
