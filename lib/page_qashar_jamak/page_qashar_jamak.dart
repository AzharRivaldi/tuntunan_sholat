import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class QasharJamakPage extends StatelessWidget {
  const QasharJamakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfControllerPinch(
      document: PdfDocument
          .openAsset('assets/data/shalat/shalat_qashar_dan_jamaq.pdf'),
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Shalat Qashar dan Jamak",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      ),
      body: Center(
          child: PdfViewPinch(
            controller: pdfController,
          ),
      ),
    );
  }
}
