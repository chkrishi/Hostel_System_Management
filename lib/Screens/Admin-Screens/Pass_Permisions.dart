import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/homepasspermission.dart';
import 'package:univproject/Screens/Widgets/outpasspermissions.dart';
import 'package:univproject/Screens/color.dart';

class PassPermisions extends StatefulWidget {
  PassPermisions({
    super.key,
  });

  @override
  State<PassPermisions> createState() => _PassPermisionsState();
}

class _PassPermisionsState extends State<PassPermisions> {
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
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Outpasspermissions()));
                    });
                  },
                  child: Text('OutPass')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Homepasspermission()));
                    });
                  },
                  child: Text('HomePass')),
            ],
          ),
        ),
      ),
    );
  }
}
