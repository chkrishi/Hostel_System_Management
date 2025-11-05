import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Stream<QuerySnapshot>> getStudentDetails(
      String? selectedYear, String? selectedDept) async {
    if (selectedYear == null || selectedDept == null) {
      throw ArgumentError('Year and Department cannot be null');
    }
    return _firestore
        .collection("Users")
        .where("Year", isEqualTo: selectedYear)
        .where("Department", isEqualTo: selectedDept)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getQueryDetails() async {
    return _firestore.collection("Query").snapshots();
  }

  Future<Stream<QuerySnapshot>> getHomePassDetails() async {
    return _firestore.collection("HomePass").snapshots();
  }

  Future<Stream<QuerySnapshot>> getOutPassDetails() async {
    return _firestore.collection("Out Pass").snapshots();
  }

  Future<Stream<QuerySnapshot>> getFeeDetails() async {
    return _firestore.collection("Fee").snapshots();
  }

  getStudDetails(String? selectedyear, String? selecteddept) {}
}
