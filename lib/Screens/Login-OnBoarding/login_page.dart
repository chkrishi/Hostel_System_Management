import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Login-OnBoarding/forgot%20password.dart';
import 'package:univproject/Screens/Login-OnBoarding/register_page.dart';
import 'package:univproject/Screens/Widgets/custombutton.dart';
import 'package:univproject/Screens/Widgets/customfield.dart';
import 'package:univproject/Screens/color.dart';
import 'package:univproject/Screens/home_screen.dart';
import 'package:univproject/Screens/studenthomescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? emailval;
  String? passwordval;

  Future<void> log() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '$emailval@kanchiuniv.ac.in',
          password: passwordval!,
        );

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user?.uid)
            .get();

        if (userDoc.exists) {
          bool isAdmin = userDoc['Auth'] ?? false;

          if (isAdmin) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            print(passwordval);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Studenthomescreen(
                    email: '$emailval@kanchiuniv.ac.in',
                    name: userDoc['Name'],
                  ),
                ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User document not found.')));
        }
      } catch (e) {
        String errorMessage = e is FirebaseAuthException
            ? _getErrorMessage(e)
            : 'An error occurred: ${e.toString()}';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'User has been disabled.';
      default:
        return 'An unknown error occurred.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              'lib/assets/images/logo.png',
              height: 453.h,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(32.w, 34.h, 32.w, 0.h),
            child: _buildLoginForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Stack(
      children: [
        Positioned(
          height: 408.h,
          width: 296.w,
          child: Column(
              children: [SizedBox(height: 64.h), SizedBox(height: 10.h)]),
        ),
        Positioned(
          top: 358.h,
          left: 0,
          right: 0,
          child: Container(
            width: 296.w,
            height: 408.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildWelcomeDivider(),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      onSaved: (val) => emailval = val,
                      hintText: 'Enter your Registration Number',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        value = '$value@kanchiuniv.ac.in';
                        return (value == null || value.isEmpty)
                            ? 'Please enter a valid email address'
                            : null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    _buildPasswordField(),
                    _buildForgotPasswordButton(),
                    SizedBox(height: 10.h),
                    CustomButton(
                        text: 'Login', width: double.infinity, onTap: log),
                    SizedBox(height: 10.h),
                    _buildRegisterSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeDivider() {
    return Row(
      children: [
        Expanded(
            child: Divider(color: AppColors.gradientcolor1, thickness: 2.h)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text("Welcome to SCSVMV ",
              style: TextStyle(
                  color: AppColors.gradientcolor1,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp)),
        ),
        Expanded(
            child: Divider(color: AppColors.gradientcolor1, thickness: 2.h)),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      cursorColor: AppColors.black,
      maxLength: 15,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            fontSize: 14.sp),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 3),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 2),
        ),
      ),
      onSaved: (val) => passwordval = val,
      validator: (value) => (value == null || value.isEmpty || value.length < 6)
          ? 'Please enter a valid password'
          : null,
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgetPasswordScreen()));
        },
        child: Text('Forgot Password ?',
            style: TextStyle(
                color: AppColors.gradientcolor1,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildRegisterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?",
            style: TextStyle(
                color: AppColors.gradientcolor1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500)),
        TextButton(
          child: Text('Register Now',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const RegistrationPage()));
          },
        ),
      ],
    );
  }
}
