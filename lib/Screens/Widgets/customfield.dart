import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool counterText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.onSaved,
      this.maxLength,
      this.counterText = false,
      this.validator,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        counterText: counterText ? null : '',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.black,
          fontSize: 14.sp,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mediumBrown,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mediumBrown,
            width: 3,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mediumBrown,
            width: 2,
          ),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
