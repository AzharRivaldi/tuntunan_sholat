import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:tuntunan_sholat/page_shalat_fardu/model_shalat_fardu.dart';

class ShalatFarduPage extends StatelessWidget {
  const ShalatFarduPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<ModelSholatFardu> modelSholatFardu = <ModelSholatFardu>[
      ModelSholatFardu(title: 'Shalat Subuh'),
      ModelSholatFardu(title: 'Shalat Dzuhur'),
      ModelSholatFardu(title: 'Shalat Ashar'),
      ModelSholatFardu(title: 'Shalat Maghrib'),
      ModelSholatFardu(title: 'Shalat Isya'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Shalat Fardu",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      ),
      body: ListView.builder(
          itemCount: modelSholatFardu.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                String strTitle = modelSholatFardu[index].title;
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OpenPDFPage(strTitle: strTitle)));
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "${index + 1}. ${modelSholatFardu[index].title}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
              ),
            );
          }),
    );
  }
}

class OpenPDFPage extends StatelessWidget {
  final String strTitle;

  const OpenPDFPage({super.key, required this.strTitle});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfControllerPinch(
      document: PdfDocument
          .openAsset('assets/data/shalat/${strTitle.toLowerCase().replaceAll(' ', '_')}.pdf'),
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Tata Cara $strTitle",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      ),
      body: Center(
          child: PdfViewPinch(
        controller: pdfController,
      )),
    );
  }
}
