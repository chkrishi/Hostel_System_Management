import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:univproject/Screens/Widgets/allsdetails.dart';
import 'package:univproject/Screens/color.dart';

class AdminDB extends StatefulWidget {
  const AdminDB({super.key});

  @override
  State<AdminDB> createState() => _AdminDBState();
}

class _AdminDBState extends State<AdminDB> {
  final departments = ['CSE', 'MECH', 'CIVIL', 'ECE', 'EEE'];
  final years = ['1', '2', '3', '4'];
  String? selectedDepartment;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Image.asset(
                'lib/assets/images/logo.png',
                height: 166.h,
                width: 186.w,
                alignment: Alignment.center,
              ),
              Text(
                'Student Database',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mediumBrown,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: buildDropdown(
                      'Filter Department',
                      selectedDepartment,
                      departments,
                      (newValue) {
                        setState(() {
                          selectedDepartment = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: buildDropdown(
                      'Filter Year',
                      selectedYear,
                      years,
                      (newValue) {
                        setState(() {
                          selectedYear = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mediumBrown,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 1.5.w)),
                  child: Allsdetails(
                    selectedyear: selectedYear,
                    selecteddept: selectedDepartment,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String hintText, String? value, List<String> items,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
