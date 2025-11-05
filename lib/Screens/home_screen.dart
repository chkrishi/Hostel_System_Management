import 'package:flutter/material.dart';
import 'package:univproject/Screens/Admin-Screens/Change_Menu.dart';

import 'package:univproject/Screens/Admin-Screens/Solve_Query.dart';
import 'package:univproject/Screens/Admin-Screens/Student_DB.dart';
import 'package:univproject/Screens/User-Screens/Hostel_fee.dart';
import 'package:univproject/Screens/User-Screens/Menu.dart';

import 'package:univproject/Screens/User-Screens/post_queries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AdminMenuScreen()));
            },
            icon: Image.asset('lib/assets/images/menu.png')),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AdminQuery()));
            },
            icon: Image.asset('lib/assets/images/query.png')),
        IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const AdminDB()));
            },
            icon: Image.asset('lib/assets/images/db.png')),
      ]),
    );
  }
}
