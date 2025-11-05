import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/customfield.dart';
import 'package:univproject/Screens/Widgets/database.dart';
import 'package:univproject/Screens/color.dart';

class Allqueries extends StatefulWidget {
  const Allqueries({super.key});

  @override
  State<Allqueries> createState() => _AllqueriesState();
}

class _AllqueriesState extends State<Allqueries> {
  Stream? queryStream;

  getontheload() async {
    queryStream = await Database().getQueryDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Query').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final users = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              decoration: BoxDecoration(border: Border.all(width: 2.w)),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Registered Mail')),
                DataColumn(label: Text('Query')),
                DataColumn(label: Text('Desciption')),
                DataColumn(label: Text('Date & Time')),
                DataColumn(label: Text('Delete')),
              ],
              rows: users.map((user) {
                final data = user.data() as Map<String, dynamic>;
                final userId = user.id;
                bool isSolved = data['Solved'] ?? false;
                return DataRow(cells: [
                  DataCell(Text(data['Name'] ?? '')),
                  DataCell(Text(data['Registered mail'] ?? '')),
                  DataCell(Text(data['Query'] ?? '')),
                  DataCell(Text(data['Description'] ?? '')),
                  DataCell(Text(data['DateTime'] ?? '')),
                  DataCell(
                    IconButton(
                      onPressed: () async {
                        await onSolved(userId, isSolved);
                      },
                      icon: Icon(
                        isSolved ? Icons.check : Icons.close,
                        color: isSolved ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Future<void> onSolved(String id, bool currentSolvedStatus) async {
    bool newSolvedStatus = !currentSolvedStatus;
    try {
      await FirebaseFirestore.instance.collection("Query").doc(id).update({
        'Solved': newSolvedStatus,
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Failed to update: $error"),
          );
        },
      );
    }
  }
}
