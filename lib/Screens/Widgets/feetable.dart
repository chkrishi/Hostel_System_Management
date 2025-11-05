import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/database.dart';
import 'package:univproject/Screens/color.dart';
import 'package:univproject/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Paymenttable extends StatefulWidget {
  const Paymenttable({super.key});

  @override
  State<Paymenttable> createState() => _PaymenttableState();
}

class _PaymenttableState extends State<Paymenttable> {
  Stream? feeStream;

  getontheload() async {
    feeStream = await Database().getFeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
            border: TableBorder.all(
              color: AppColors.black,
              width: 2.w,
              borderRadius: BorderRadius.all(
                Radius.circular(5.r),
              ),
            ),
            children: [
              TableRow(
                children: [
                  Text(
                    'Date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                  Text(
                    'Mail Id',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                  Text(
                    'Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                  Text(
                    'Amount Paid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mediumBrown,
                    ),
                  )
                ],
                decoration: BoxDecoration(color: AppColors.cardback),
              ),
            ]),
        StreamBuilder(
            stream: feeStream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return Table(
                            border: TableBorder.all(
                              color: AppColors.black,
                              width: 2.w,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                            ),
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    ds['Name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mediumBrown,
                                    ),
                                  ),
                                  Text(
                                    ds['Registered Mail'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mediumBrown,
                                    ),
                                  ),
                                  Text(
                                    ds['Amount'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mediumBrown,
                                    ),
                                  ),
                                  Text(
                                    ds['DateTime'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mediumBrown,
                                    ),
                                  )
                                ],
                                decoration:
                                    BoxDecoration(color: AppColors.cardback),
                              ),
                            ]);
                      })
                  : Container();
            })
      ],
    );
  }
}
