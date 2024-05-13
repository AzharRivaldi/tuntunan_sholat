import 'package:flutter/material.dart';
import 'package:tuntunan_sholat/page_home/model_home.dart';
import 'package:tuntunan_sholat/page_qashar_jamak/page_qashar_jamak.dart';
import 'package:tuntunan_sholat/page_shalat_fardu/page_shalat_fardu.dart';
import 'package:tuntunan_sholat/page_shalat_sunnah/page_shalat_sunnah.dart';
import 'package:tuntunan_sholat/page_sick/page_shalat_saat_sakit.dart';
import 'package:tuntunan_sholat/page_tayammum/page_tayammum.dart';
import 'package:tuntunan_sholat/page_wudhu/page_wudhu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<ModelHome> modelHome = <ModelHome>[
      ModelHome(title: 'Wudhu', icon: Icons.clean_hands_outlined),
      ModelHome(title: 'Tayammum', icon: Icons.front_hand_outlined),
      ModelHome(title: 'Shalat Fardu', icon: Icons.man),
      ModelHome(title: 'Shalat Sunnah', icon: Icons.man),
      ModelHome(title: 'Shalat Qashar dan Jamak', icon: Icons.access_time_outlined),
      ModelHome(title: 'Shalat Saat Sakit', icon: Icons.sick_outlined),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Image(
              image: AssetImage('assets/images/ic_shalat.png'),
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Tuntunan Shalat",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 6,
        children: List.generate(
          modelHome.length, (index) {
            var items = modelHome[index];
            return GestureDetector(
              onTap: () {
                if (items.title == 'Wudhu') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WudhuPage()));
                } else if (items.title == 'Tayammum') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TayammumPage()));
                } else if (items.title == 'Shalat Fardu') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShalatFarduPage()));
                } else if (items.title == 'Shalat Sunnah') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShalatSunnahPage()));
                } else if (items.title == 'Shalat Qashar dan Jamak') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QasharJamakPage()));
                } else if (items.title == 'Shalat Saat Sakit') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShalatSaatSakitPage()));
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                color: Colors.orange,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Icon(modelHome[index].icon,
                              size: 80, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(modelHome[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
