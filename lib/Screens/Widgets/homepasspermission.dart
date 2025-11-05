import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/database.dart';

class Homepasspermission extends StatefulWidget {
  const Homepasspermission({super.key});

  @override
  State<Homepasspermission> createState() => _HomepasspermissionState();
}

class _HomepasspermissionState extends State<Homepasspermission> {
  Stream? homeStream;

  getontheload() async {
    homeStream = await Database().getHomePassDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('HomePass').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final users = snapshot.data!.docs;

                return Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 1.5.w)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            decoration:
                                BoxDecoration(border: Border.all(width: 1.5.w)),
                            columns: const [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Registered Mail')),
                              DataColumn(label: Text('Reason')),
                              DataColumn(label: Text('Place')),
                              DataColumn(label: Text('Date & Time')),
                              DataColumn(label: Text('Return Date')),
                              DataColumn(label: Text('Approved')),
                            ],
                            rows: users.map((user) {
                              final data = user.data() as Map<String, dynamic>;
                              final userId = user.id;
                              bool isSolved = data['Approved'] ?? false;
                              return DataRow(cells: [
                                DataCell(Text(data['Name'] ?? '')),
                                DataCell(Text(data['Registered mail'] ?? '')),
                                DataCell(Text(data['Reason'] ?? '')),
                                DataCell(Text(data['Place'] ?? '')),
                                DataCell(Text(data['Date'] ?? '')),
                                DataCell(Text(data['Return Date'] ?? '')),
                                DataCell(
                                  IconButton(
                                    onPressed: () async {
                                      await onSolved(userId, isSolved);
                                    },
                                    icon: Icon(
                                      isSolved ? Icons.check : Icons.close,
                                      color:
                                          isSolved ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }

  Future<void> onSolved(String id, bool currentSolvedStatus) async {
    bool newSolvedStatus = !currentSolvedStatus;
    try {
      await FirebaseFirestore.instance.collection("Out Pass").doc(id).update({
        'Approved': newSolvedStatus,
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
