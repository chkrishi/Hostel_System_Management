import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/custombutton.dart';
import 'package:univproject/Screens/Widgets/customfield.dart';
import 'package:univproject/Screens/color.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class Validator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your registration number';
    }
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@kanchiuniv\.ac\.in$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch('$value+@kanchiuniv.ac.in')) {
      return 'Enter a valid registration number';
    }
    return null;
  }

  static bool emailValidate(String? email) {
    final emailPattern = r'^[a-zA-Z0-9._%+-]+@kanchiuniv\.ac\.in$';
    final regex = RegExp(emailPattern);
    return email != null && regex.hasMatch(email);
  }
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  bool _isUpdated = false;
  bool _isLoading = false;

  void _onChanged() {
    _formKey.currentState?.save();
    setState(() {
      _isUpdated = Validator.emailValidate(_email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 37.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  'Prev',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mediumBrown,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Image.asset(
              'lib/assets/images/logo.png',
              height: 166.h,
              width: 186.w,
            ),
            Text(
              'Forgot\nPassword',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.mediumBrown,
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Don\'t worry! It happens. Please enter the email address associated with your registration number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mediumBrown,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                onChanged: _onChanged,
                child: CustomTextField(
                  hintText: 'Enter Your Registration Number',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _email = '$value@kanchiuniv.ac.in',
                  validator: Validator.emailValidator,
                ),
              ),
            ),
            SizedBox(height: 35.h),
            CustomButton(
              text: _isLoading ? 'Sending...' : 'Send Email',
              isEnabled: _isUpdated && !_isLoading,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _email!.trim());
                    setState(() {
                      _isUpdated = true;
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password reset email sent!")),
                    );
                  } catch (error) {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("Failed to send email. Please try again.")),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
