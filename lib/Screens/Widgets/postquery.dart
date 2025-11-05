import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/user_repo.dart';
import 'package:univproject/Screens/Widgets/usermodel.dart';
import 'package:univproject/Screens/color.dart';
import 'package:intl/intl.dart';

class Postquery extends StatefulWidget {
  String email;
  String name;
  Postquery({super.key, required this.email, required this.name});

  @override
  State<Postquery> createState() => _PostqueryState();
}

class _PostqueryState extends State<Postquery> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descript = TextEditingController();

  String? selectedQueryType;
  String? dateTime;
  String? descp;

  final List<String> queryTypes = [
    'Food',
    'Furniture',
    'Room Change',
    'Staff',
    'Other'
  ];

  @override
  void dispose() {
    descript.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DateTime now = DateTime.now();
      String fDate = DateFormat('yyyy-MM-dd').format(now);
      String fTime = DateFormat('HH:mm:ss').format(now);
      dateTime = '$fDate $fTime';
      final query1 = PostQueryModel(
          name: widget.name,
          querytype: selectedQueryType,
          datetime: dateTime,
          description: descp,
          email: widget.email,
          solved: false);
      UserRepo obj4 = UserRepo();
      await obj4.createNewQuery(query1);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Query Form submitted successfully!')),
      );
      _formKey.currentState!.reset();
      setState(() {
        dateTime = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 100.h),
            DropdownButtonFormField<String>(
              items: queryTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedQueryType = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Query Type',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val == null) {
                  return 'Please select a query type';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: descript,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
                border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.mediumBrown, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.mediumBrown, width: 3),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.mediumBrown, width: 2),
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
              onSaved: (newValue) {
                descp = newValue;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submit,
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
