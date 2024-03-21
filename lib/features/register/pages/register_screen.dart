
import 'package:flutter/material.dart';
import 'package:todo_app_new/features/layout_home/layout_view.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';

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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFDFECDB),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 115,
          centerTitle: true,
          title: Text(
            'Create Account',
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
                    'Full Name',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your Full Name',
                    suffixIcon: Icon(Icons.person),
                    keyboardType: TextInputType.text,
                    controller: fullNameController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter your full name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'E-mail',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your e-mail address',
                    suffixIcon: Icon(Icons.email_rounded),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "E-mail required";
                      }
                      var regexp = RegExp(emailPattern);
                      if (!regexp.hasMatch(value)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Password',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your password',
                    isPassword: true,
                    controller: passwordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password required";
                      }
                      var regexp = RegExp(passPattern);
                      if (!regexp.hasMatch(value)) {
                        return "Invalid password \n* the password must be Minimum eight characters,\n* at least one uppercase letter,\n* one lowercase letter,\n* one number and one special character";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Confirm Password',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your confirm password',
                    isPassword: true,
                    controller: confirmPasswordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Confirm password required";
                      }
                      if (value != passwordController.text) {
                        return "password not matched";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
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
                            Navigator.pushNamedAndRemoveUntil(context,
                                LayoutView.routeName, (route) => false);
                          },
                          onError: (errorMessage) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(errorMessage),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('try again'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('cancel'),
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
                          'Create Account',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
