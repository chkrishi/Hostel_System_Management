import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:univproject/Screens/Widgets/customfield.dart';
import 'package:univproject/Screens/color.dart';
import 'package:univproject/Screens/Widgets/user_repo.dart';
import 'package:univproject/Screens/Widgets/usermodel.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final departments = ['CSE', 'MECH', 'CIVIL', 'ECE', 'EEE'];
  final years = ['1', '2', '3', '4'];

  String? selectedDepartment;
  String? selectedYear;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? name1;
  String? surname1;
  String? pno;
  String? parentpno;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passwordsMatch = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordsMatch() {
    setState(() {
      passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _registerAndSendEmailVerification() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _checkPasswordsMatch();

      if (!passwordsMatch) return;

      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        if (userCredential.user != null &&
            !userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();

          final user = Usermodel(
            name1: name1,
            surname1: surname1,
            pno: pno,
            parentpno: parentpno,
            selectedDepartment: selectedDepartment,
            selectedYear: selectedYear,
            email: _email,
          );

          UserRepo obj1 = UserRepo();
          await obj1.createNewUser(user);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Verification email sent to $_email'),
            backgroundColor: Colors.green,
          ));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: 166.h,
                  width: 186.w,
                ),
                Text(
                  'Registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mediumBrown,
                  ),
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  hintText: 'Name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a value for Name';
                    }
                    return '';
                  },
                  onSaved: (value) {
                    name1 = value;
                  },
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  hintText: 'Surname',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a value for Surname';
                    }
                    return '';
                  },
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    surname1 = value;
                  },
                ),
                SizedBox(height: 25.h),
                DropdownButtonFormField<String>(
                  value: selectedDepartment,
                  decoration: InputDecoration(
                    hintText: 'Select Department',
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  items:
                      departments.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select a valid Department';
                    }
                    return '';
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDepartment = newValue;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                DropdownButtonFormField<String>(
                  value: selectedYear,
                  decoration: InputDecoration(
                    hintText: 'Select Year',
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  items: years.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select a valid Year';
                    }
                    return '';
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  hintText: 'Phone number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Phone Number';
                    } else if (value.length != 10) {
                      return 'Enter a valid Phone Number';
                    }
                    return '';
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    pno = value;
                  },
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  hintText: 'Parent Phone number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Parent\'s Phone Number';
                    } else if (value.length != 10) {
                      return 'Enter a valid Phone Number';
                    }
                    return '';
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    parentpno = value;
                  },
                ),
                SizedBox(height: 25.h),
                CustomTextField(
                  hintText: 'Registration Number',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _email = '$value@kanchiuniv.ac.in';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _password = value,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) => _checkPasswordsMatch(),
                ),
                SizedBox(height: 25.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) => _checkPasswordsMatch(),
                ),
                SizedBox(height: 25.h),
                if (!passwordsMatch)
                  Text(
                    'Passwords do not match!',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 25.h),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _registerAndSendEmailVerification,
                        child: Text('Send Verification Email'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
