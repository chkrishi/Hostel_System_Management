import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/Query_record.dart';
import 'package:univproject/Screens/Widgets/allqueries.dart';
import 'package:univproject/Screens/Widgets/postquery.dart';
import 'package:univproject/Screens/color.dart';

class UserQueries extends StatefulWidget {
  String email;
  String name;
  UserQueries({super.key, required this.email, required this.name});

  @override
  State<UserQueries> createState() => _UserQueriesState();
}

class _UserQueriesState extends State<UserQueries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(height: 70.h),
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: 166.h,
                  width: 186.w,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 2.w)),
                  child: Column(
                    children: [
                      Text(
                        'Post Queries',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.mediumBrown,
                        ),
                      ),
                      Postquery(
                        name: widget.name,
                        email: widget.email,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Query Record',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mediumBrown,
                  ),
                ),
                QueryRecord(email: widget.email, name: widget.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
