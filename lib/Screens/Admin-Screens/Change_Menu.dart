import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminMenuScreen extends StatefulWidget {
  @override
  _AdminMenuScreenState createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  File? file;
  String? pdfUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdfUrl();
  }

  Future<void> loadPdfUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref().child('Users/menu.pdf');
      pdfUrl = await ref.getDownloadURL();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(msg: 'Error loading PDF');
      });
    }
  }

  Future<void> uploadNewPdf() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
      if (file != null) {
        try {
          setState(() {
            isLoading = true;
          });
          String fileName = 'menu.pdf';
          var storageRef =
              FirebaseStorage.instance.ref().child('Users').child(fileName);
          await storageRef.putFile(file!);
          String downloadUrl = await storageRef.getDownloadURL();
          setState(() {
            pdfUrl = downloadUrl;
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'PDF uploaded successfully');
        } catch (e) {
          Fluttertoast.showToast(msg: 'Upload failed');
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload PDF')),
      body: Column(
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : pdfUrl != null
                  ? Expanded(
                      child: PDFView(
                        filePath: pdfUrl,
                      ),
                    )
                  : Center(child: Text('No PDF found')),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: uploadNewPdf,
            child: Text('Replace PDF'),
          ),
        ],
      ),
    );
  }
}
