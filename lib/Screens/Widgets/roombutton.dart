import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/color.dart';

class Roombutton extends StatefulWidget {
  final String key1;
  const Roombutton({super.key, required this.key1});

  @override
  State<Roombutton> createState() => _RoombuttonState();
}

class _RoombuttonState extends State<Roombutton> {
  Color colval = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
      color: AppColors.cream,
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                setState(() {
                  if (colval == Colors.red) {
                    colval = Colors.blue;
                  } else if (colval == Colors.blue) {
                    colval = Colors.red;
                  }
                });
              },
              child: Text(
                widget.key1,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: colval,
                    fontWeight: FontWeight.w500),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(
                    fontSize: 7.sp,
                    color: AppColors.appBargradient1,
                    fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
