import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:tuntunan_sholat/page_wudhu/model_wudhu.dart';
import 'package:flutter/services.dart' as rootBundle;

class WudhuPage extends StatelessWidget {
  const WudhuPage({super.key});

  Future<List<ModelWudhu>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data/wudhu/page_wudhu.json');
    final listData = json.decode(jsonData) as List<dynamic>;
    return listData.map((e) => ModelWudhu.fromJson(e)).toList();
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
            "Wudhu",
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
              var items = data.data as List<ModelWudhu>;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          unselectedWidgetColor: Colors.black,
                          colorScheme: const ColorScheme.light(
                            primary: Colors.orange,
                          ),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            items[index].title.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (items[index].title == 'Tata Cara Wudhu') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const OpenPDFPage()));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          items[index].content.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
  const OpenPDFPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/data/wudhu/page_wudhu.pdf'),
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
            "Tata Cara Wudhu",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      ),
      body: Center(
          child: PdfViewPinch(
            controller: pdfController,
          )
      ),
    );
  }
}

