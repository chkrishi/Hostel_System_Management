import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Outpasspermissions extends StatefulWidget {
  const Outpasspermissions({super.key});

  @override
  State<Outpasspermissions> createState() => _OutpasspermissionsState();
}

class _OutpasspermissionsState extends State<Outpasspermissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Out Pass').snapshots(),
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
                    decoration: BoxDecoration(border: Border.all(width: 1.5.w)),
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
                          DataColumn(label: Text('Approved')),
                        ],
                        rows: users.map((user) {
                          final data = user.data() as Map<String, dynamic>;
                          final userId = user.id;
                          bool isApproved = data['Approved'] ?? false;

                          return DataRow(cells: [
                            DataCell(Text(data['Name'] ?? '')),
                            DataCell(Text(data['Registered mail'] ?? '')),
                            DataCell(Text(data['Reason'] ?? '')),
                            DataCell(Text(data['Place'] ?? '')),
                            DataCell(Text(data['DateTime'] ?? '')),
                            DataCell(
                              IconButton(
                                onPressed: () async {
                                  await onSolved(userId, isApproved);
                                },
                                icon: Icon(
                                  isApproved ? Icons.check : Icons.close,
                                  color: isApproved ? Colors.green : Colors.red,
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
          },
        ),
      ),
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
