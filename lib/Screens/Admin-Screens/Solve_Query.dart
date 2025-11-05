import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/allqueries.dart';
import 'package:univproject/Screens/color.dart';

class AdminQuery extends StatefulWidget {
  const AdminQuery({super.key});

  @override
  State<AdminQuery> createState() => _AdminQueryState();
}

class _AdminQueryState extends State<AdminQuery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Image.asset(
                'lib/assets/images/logo.png',
                height: 166.h,
                width: 186.w,
                alignment: Alignment.center,
              ),
              Text(
                'All Queries',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mediumBrown,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Allqueries(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
