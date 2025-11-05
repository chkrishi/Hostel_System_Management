//Timer
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/main.dart';

class Timercount extends StatefulWidget {
  const Timercount({super.key});

  @override
  State<Timercount> createState() => _TimercountState();
}

class _TimercountState extends State<Timercount> {
  int remaining_time = 30;
  Timer? time_counter;
  @override
  void initState() {
    super.initState();
    initializetimer();
  }

  void initializetimer() {
    time_counter = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remaining_time == 0) {
          timer.cancel();
        } else {
          setState(() {
            remaining_time--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    time_counter?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$remaining_time s',
      style: TextStyle(
          fontSize: 14.sp,
          color: Color.fromARGB(255, 136, 73, 21),
          fontWeight: FontWeight.w500),
    );
  }
}
