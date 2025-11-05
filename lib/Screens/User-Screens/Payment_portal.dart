import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:univproject/Screens/Widgets/feetable.dart';
import 'package:univproject/Screens/Widgets/payment1.dart';
import 'package:univproject/Screens/color.dart';

class PaymentPortal extends StatefulWidget {
  String name;
  String email;
  PaymentPortal({super.key, required this.name, required this.email});

  @override
  State<PaymentPortal> createState() => _PaymentPortalState();
}

class _PaymentPortalState extends State<PaymentPortal> {
  @override
  String fDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String fTime = DateFormat('HH:mm:ss').format(DateTime.now());
  void setState(VoidCallback fn) {
    String dateTime1 = '$fDate $fTime';
    super.setState(fn);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
          child: SingleChildScrollView(
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
                  'Payment Portal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mediumBrown,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.cardback,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:\t ${widget.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mediumBrown,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Email:\t ${widget.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mediumBrown,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'DateTime : \t$fDate $fTime',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mediumBrown,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Amount Paid: 10/-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mediumBrown,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 120.w,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Payment1()));
                              },
                              child: Text('Proceed To Payment'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Payment History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mediumBrown,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Paymenttable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
