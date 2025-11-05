import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:univproject/Screens/Widgets/user_repo.dart';
import 'package:univproject/Screens/Widgets/usermodel.dart';
import 'package:univproject/Screens/color.dart';

class Outpass extends StatefulWidget {
  String? email;
  String? name;
  Outpass({super.key, required this.email, required this.name});

  @override
  State<Outpass> createState() => _OutpassState();
}

class _OutpassState extends State<Outpass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  String dateTime = '';
  String? reason;
  String? place;

  @override
  void dispose() {
    reasonController.dispose();
    placeController.dispose();

    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DateTime now = DateTime.now();
      String fDate = DateFormat('yyyy-MM-dd').format(now);
      String fTime = DateFormat('HH:mm:ss').format(now);
      dateTime = '$fDate $fTime';
      final outpass = Outpassmodel(
          name: widget.name,
          reason: reason,
          place: place,
          date: dateTime,
          email: widget.email,
          approved: false);
      UserRepo obj3 = UserRepo();
      await obj3.createNewoutpass(outpass);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Out-Pass Form submitted successfully!')),
      );
      _formKey.currentState!.reset();
      setState(() {
        dateTime = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Out-Pass',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mediumBrown,
                  ),
                ),
                SizedBox(height: 50.h),
                _buildTextField(
                    controller: placeController,
                    hint: 'Place',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Please enter a place'
                        : null,
                    onsaved: (val) {
                      place = val;
                    }),
                SizedBox(height: 20.h),
                _buildTextField(
                    controller: reasonController,
                    hint: 'Reason',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Please enter a reason'
                        : null,
                    onsaved: (val) {
                      reason = val;
                    }),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                      ),
                      child: Text('Submit'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.mediumBrown),
                      ),
                      child: Text('Cancel',
                          style: TextStyle(color: AppColors.mediumBrown)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    required Function(String?) onsaved,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: 100,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.black.withOpacity(0.6),
          fontSize: 14.sp,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumBrown, width: 2),
        ),
      ),
      validator: validator,
      onSaved: onsaved,
    );
  }
}
