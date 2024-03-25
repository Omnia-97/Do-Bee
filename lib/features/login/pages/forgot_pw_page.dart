import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/core/config/app_theme_manager.dart';

import '../widgets/custom_textformfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

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
  Future resetPassword()async{
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
     showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Reset Password'),
             content: Text('Password reset link sent! check your Email '),
             actions: [
               ElevatedButton(
                 onPressed: () {
                   Navigator.pop(context);
                 },
                 child: Text('ok'),
               ),
               ElevatedButton(
                 onPressed: () {},
                 child: Text('cancel'),
               ),
             ],
           );
         });
   } on FirebaseAuthException catch (e){
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Error'),
             content: Text(e.message.toString()),
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
   }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppThemeManager.primaryColor,
        title: Text('Forgot Password', style: theme.textTheme.titleLarge),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Enter Your Email and we will send you a password reset link',
              style: theme.textTheme.displayMedium?.copyWith(
                height: 1.5
              ),
              textAlign: TextAlign.center,

            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormFieldRegister(
              hintText: 'Enter your e-mail address',
              suffixIcon: Icon(Icons.email_rounded),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "please enter your email";
                }
                return null;
              },
            ),
            SizedBox(
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
                'Reset Password',
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
