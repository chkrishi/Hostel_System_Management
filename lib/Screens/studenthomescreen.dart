import 'package:flutter/material.dart';
import 'package:univproject/Screens/User-Screens/Hostel_fee.dart';
import 'package:univproject/Screens/User-Screens/Menu.dart';
import 'package:univproject/Screens/User-Screens/post_queries.dart';

class Studenthomescreen extends StatefulWidget {
  String email;
  String name;
  Studenthomescreen({super.key, required this.email, required this.name});

  @override
  State<Studenthomescreen> createState() => _StudenthomescreenState();
}

class _StudenthomescreenState extends State<Studenthomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Userfee()));
              },
              icon: Image.asset('lib/assets/images/fee.png')),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const UserMenu()));
              },
              icon: Image.asset('lib/assets/images/menu.png')),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => UserQueries(
                          email: widget.email,
                          name: widget.name,
                        )));
              },
              icon: Image.asset('lib/assets/images/query.png')),
        ]));
  }
}
