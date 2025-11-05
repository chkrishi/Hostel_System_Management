import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Login-OnBoarding/register_page.dart';
import 'package:univproject/Screens/Widgets/timer.dart';
import 'package:univproject/Screens/color.dart';

class Vaildify extends StatefulWidget {
  const Vaildify({super.key});

  @override
  State<Vaildify> createState() => _VaildifyState();
}

class _VaildifyState extends State<Vaildify> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool passwordsMatch = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkPasswordsMatch() {
    setState(() {
      passwordsMatch =
          passwordController.text == confirmPasswordController.text;
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
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
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
              'Verification',
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
                'Check your email for the verification link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mediumBrown,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Timercount(),
                SizedBox(width: 5.w),
                TextButton(
                  onPressed: () {
                    // Logic for resending email
                  },
                  child: Text(
                    'Re-Send',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),

            // Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => checkPasswordsMatch(),
              ),
            ),
            SizedBox(height: 20.h),

            // Confirm Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => checkPasswordsMatch(),
              ),
            ),
            SizedBox(height: 20.h),

            // Show error message if passwords do not match
            if (!passwordsMatch)
              Text(
                'Passwords do not match!',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20.h),

            // Submit Button
            ElevatedButton(
              onPressed: passwordsMatch
                  ? () {
                      print('Passwords match! Proceeding...');
                      // Proceed with submission logic
                    }
                  : null, // Disable button if passwords do not match
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
