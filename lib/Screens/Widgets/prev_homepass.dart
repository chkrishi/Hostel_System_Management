import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrevHomepass extends StatefulWidget {
  String email;
  PrevHomepass({super.key, required this.email});

  @override
  State<PrevHomepass> createState() => _PrevHomepassState();
}

class _PrevHomepassState extends State<PrevHomepass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('HomePass')
              .where("Registered mail", isEqualTo: widget.email)
              .snapshots(),
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
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  DataTable(
                    decoration: BoxDecoration(border: Border.all(width: 1.5.w)),
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Place')),
                      DataColumn(label: Text('Reason')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Registered Mail')),
                      DataColumn(label: Text('Date & Time')),
                      DataColumn(label: Text('Approved')),
                    ],
                    rows: users.map((user) {
                      final data = user.data() as Map<String, dynamic>;
                      final userId = user.id;

                      bool isSolved = data['Approved'] ?? false;

                      return DataRow(cells: [
                        DataCell(Text(data['Name'] ?? '')),
                        DataCell(Text(data['Registered mail'] ?? '')),
                        DataCell(Text(data['Place'] ?? '')),
                        DataCell(Text(data['Address'] ?? '')),
                        DataCell(Text(data['Reason'] ?? '')),
                        DataCell(Text(data['DateTime'] ?? '')),
                        DataCell(isSolved
                            ? Text(
                                'Approved',
                                style: TextStyle(color: Colors.greenAccent),
                              )
                            : Text(
                                'Not Approved',
                                style: TextStyle(color: Colors.redAccent),
                              )),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
