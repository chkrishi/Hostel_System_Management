import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:univproject/Screens/Admin-Screens/Change_Menu.dart';
import 'package:univproject/Screens/Admin-Screens/Pass_Permisions.dart';
import 'package:univproject/Screens/Admin-Screens/Solve_Query.dart';
import 'package:univproject/Screens/Admin-Screens/Student_DB.dart';
import 'package:univproject/Screens/Login-OnBoarding/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/User-Screens/Menu.dart';
import 'package:univproject/Screens/User-Screens/Pass.dart';
import 'package:univproject/Screens/User-Screens/Payment_portal.dart';
import 'package:univproject/Screens/User-Screens/post_queries.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      child: Builder(builder: (context) {
        return MaterialApp(
          home: /*  PaymentPortal(
            name: 'Rishi',
            email: '11219a004@kanchiuniv.ac.in',
          ), */
              //__________________________________________
              /*  AdminMenuScreen(), */
              /* UserMenu(), */
              //____________________________________________
              /* AdminDB(), */
              /*  PaymentPortal(), */
              //_____________________________________________
              LoginPage(),
          //__________________________________________________
          /*  PassPermisions(), */
          /*  Pass(
            name: 'Rishi',
            email: '11219a004@kanchiuniv.ac.in',
          ), */
          //__________________________________________________
          /* AdminQuery(), */
          /*  UserQueries(
            email: '11219a035@kanchiuniv.ac.in',
            name: 'Pradeep',
          ), */
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
