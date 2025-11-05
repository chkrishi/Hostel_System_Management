import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:univproject/Screens/Widgets/usermodel.dart';
import 'package:univproject/Screens/color.dart';

class UserRepo {
  final db = FirebaseFirestore.instance;

  Future<void> createNewUser(Usermodel user1) async {
    await db.collection("Users").add(user1.Tojson()).whenComplete(() {
      Get.snackbar("Success", "Your account has been created",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    });
  }

  Future<void> createNewhomepass(Homepassmodel home1) async {
    await db.collection("HomePass").add(home1.Tojson()).whenComplete(() {
      Get.snackbar("Success", "Your Home pass request has been created",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    });
  }

  Future<void> createNewoutpass(Outpassmodel out1) async {
    await db.collection("Out Pass").add(out1.Tojson()).whenComplete(() {
      Get.snackbar("Success", "Your Out pass request has been created",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    });
  }

  Future<void> createNewQuery(PostQueryModel query1) async {
    await db.collection("Query").add(query1.Tojson()).whenComplete(() {
      Get.snackbar("Success", "Your Query has been sent",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.appBargradient1);
    });
  }
}
