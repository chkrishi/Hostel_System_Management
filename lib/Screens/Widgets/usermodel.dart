class Usermodel {
  String? name1;
  String? surname1;
  String? pno;
  String? parentpno;
  String? selectedDepartment;
  String? selectedYear;
  String? email;
  bool? val;

  Usermodel({
    required this.name1,
    required this.surname1,
    required this.pno,
    required this.parentpno,
    required this.selectedDepartment,
    required this.selectedYear,
    required this.email,
    this.val = false,
  });

  Map<String, dynamic> Tojson() {
    return {
      'Auth': val,
      'Department': selectedDepartment,
      'Name': name1,
      'Parent\'s Phone no': parentpno,
      'Phone no': pno,
      'Register number': email,
      'Surname': surname1,
      'Year': selectedYear,
    };
  }
}

class Homepassmodel {
  String? reason;
  String? address;
  String? place;
  String? date;
  String? rdate;
  String? email;
  bool? approved;
  Homepassmodel(
      {required this.reason,
      required this.address,
      required this.place,
      required this.date,
      required this.rdate,
      required this.email,
      required this.approved});

  Map<String, dynamic> Tojson() {
    return {
      'Address': address,
      'Date': date,
      'Return Date': rdate,
      'Place': place,
      'Reason': reason,
      'Registered mail': email,
      'Approved': approved,
    };
  }
}

class Outpassmodel {
  String? name;
  String? reason;
  String? address;
  String? place;
  String? date;
  bool? approved;
  String? email;

  Outpassmodel({
    required this.name,
    required this.reason,
    required this.place,
    required this.date,
    required this.approved,
    required this.email,
  });

  Map<String, dynamic> Tojson() {
    return {
      'Name': name,
      'Date': date,
      'Approved': approved,
      'Reason': reason,
      'Registered mail': email,
    };
  }
}

class PostQueryModel {
  String? name;
  String? querytype;
  String? description;
  bool? solved;
  String? datetime;
  String? email;

  PostQueryModel({
    required this.name,
    required this.querytype,
    required this.datetime,
    required this.description,
    required this.solved,
    required this.email,
  });

  Map<String, dynamic> Tojson() {
    return {
      'Name': name,
      'Solved': solved,
      'DateTime': datetime,
      'Query': querytype,
      'Description': description,
      'Registered mail': email,
    };
  }
}
