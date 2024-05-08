import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:pdfx/pdfx.dart';
import 'package:tuntunan_sholat/page_shalat_sunnah/model_shalat_sunnah.dart';

class ShalatSunnahPage extends StatelessWidget {
  const ShalatSunnahPage({super.key});

  Future<List<ModelSholatSunnah>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data/shalat/shalat_sunnah.json');
    final listData = json.decode(jsonData) as List<dynamic>;
    return listData.map((e) => ModelSholatSunnah.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
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
            "Shalat Sunnah",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<ModelSholatSunnah>;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        String strTitle = items[index].title.toString();
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
                            "${index + 1}. ${items[index].title}",
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
              );
            }
          },
        ),
      ),
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
            strTitle,
            style: const TextStyle(
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