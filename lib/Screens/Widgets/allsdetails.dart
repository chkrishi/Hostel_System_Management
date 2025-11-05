import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/customfield.dart';
import 'package:univproject/Screens/color.dart';

class Allsdetails extends StatefulWidget {
  final String? selectedyear;
  final String? selecteddept;

  Allsdetails({
    super.key,
    required this.selectedyear,
    required this.selecteddept,
  });

  @override
  State<Allsdetails> createState() => _AllsdetailsState();
}

class _AllsdetailsState extends State<Allsdetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
                DataColumn(label: Text('Register Number')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Year')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Phone Number')),
                DataColumn(label: Text("Parent's Phone")),
                DataColumn(label: Text('Surname')),
                DataColumn(label: Text('Edit')),
                DataColumn(label: Text('Delete')),
              ],
              rows: users.map((user) {
                final data = user.data() as Map<String, dynamic>;
                final userId = user.id;

                return DataRow(cells: [
                  DataCell(Text(data['Register number'] ?? '')),
                  DataCell(Text(data['Name'] ?? '')),
                  DataCell(Text(data['Year'] ?? '')),
                  DataCell(Text(data['Department'] ?? '')),
                  DataCell(Text(data['Phone no'] ?? '')),
                  DataCell(Text(data['Parent\'s Phone no'] ?? '')),
                  DataCell(Text(data['Surname'] ?? '')),
                  DataCell(
                    IconButton(
                      onPressed: () =>
                          editStudentDetails(userId, data, context),
                      icon: Icon(Icons.edit),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      onPressed: () => confirmDeleteUser(userId),
                      icon: Icon(Icons.delete),
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

  final departments = ['CSE', 'MECH', 'CIVIL', 'ECE', 'EEE'];
  final years = ['1', '2', '3', '4'];
  String? selectedDepartment;
  String? selectedYear;
  String? name1;
  String? surname1;
  String? pno;
  String? parentpno;

  Future<void> editStudentDetails(
      String id, Map<String, dynamic> studentData, BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    name1 = studentData["Name"];
    surname1 = studentData["Surname"];
    selectedDepartment = studentData["Department"];
    selectedYear = studentData["Year"];
    pno = studentData["Phone no"];
    parentpno = studentData["Parent's Phone no"];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(Icons.cancel),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Edit Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                  CustomTextField(
                    initialValue: name1,
                    hintText: 'Name',
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      name1 = value;
                    },
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    initialValue: surname1,
                    hintText: 'Surname',
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      surname1 = value;
                    },
                  ),
                  SizedBox(height: 25.h),
                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    decoration: InputDecoration(
                      hintText: 'Select Department',
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: departments
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 25.h),
                  DropdownButtonFormField<String>(
                    value: selectedYear,
                    decoration: InputDecoration(
                      hintText: 'Select Year',
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: years.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    initialValue: pno,
                    hintText: 'Phone number',
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      pno = value;
                    },
                  ),
                  SizedBox(height: 25.h),
                  CustomTextField(
                    initialValue: parentpno,
                    hintText: 'Parent Phone number',
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      parentpno = value;
                    },
                  ),
                  SizedBox(height: 25.h),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(id)
                            .update({
                          'Name': name1,
                          'Surname': surname1,
                          'Department': selectedDepartment,
                          'Year': selectedYear,
                          'Phone no': pno,
                          'Parent\'s Phone no': parentpno,
                        }).then((value) {
                          Navigator.pop(context);
                        }).catchError((error) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text("Failed to update student: $error"),
                              );
                            },
                          );
                        });
                      }
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> confirmDeleteUser(String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteUser(id);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(id).delete();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("User successfully deleted."),
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Failed to delete user: $error"),
          );
        },
      );
    }
  }
}
