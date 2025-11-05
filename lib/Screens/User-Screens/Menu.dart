import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  String? pdfUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPDF();
  }

  Future<void> fetchPDF() async {
    try {
      final ref = FirebaseStorage.instance.ref().child('Users/menu.pdf');
      pdfUrl = await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching PDF: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu PDF')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pdfUrl != null
              ? PDFView(filePath: pdfUrl)
              : Center(child: Text('No PDF found')),
    );
  }
}
