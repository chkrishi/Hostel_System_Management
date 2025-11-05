import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/homepass.dart';
import 'package:univproject/Screens/Widgets/outpass.dart';
import 'package:univproject/Screens/Widgets/prev_homepass.dart';
import 'package:univproject/Screens/Widgets/prev_outpass.dart';

class Pass extends StatefulWidget {
  final String email;
  final String name;
  Pass({super.key, required this.email, required this.name});

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Outpass(
                          name: widget.name,
                          email: widget.email,
                        ),
                      ),
                    );
                  },
                  child: Text('Out-Pass'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Homepass(email: widget.email),
                      ),
                    );
                  },
                  child: Text('Home-Pass'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              PrevOutpass(email: widget.email)),
                    );
                  },
                  child: Text('Out-Pass Records'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PrevHomepass(email: widget.email),
                      ),
                    );
                  },
                  child: Text('Home-Pass Records'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
