import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryRecord extends StatefulWidget {
  final String email;

  QueryRecord({super.key, required this.email, required String name});

  @override
  State<QueryRecord> createState() => _QueryRecordState();
}

class _QueryRecordState extends State<QueryRecord> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Query')
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
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Registered Mail')),
                DataColumn(label: Text('Query')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Date & Time')),
                DataColumn(label: Text('Solved')),
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
                    Icon(
                      isSolved ? Icons.check : Icons.close,
                      color: isSolved ? Colors.green : Colors.red,
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
}
