import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/AColors.dart';
import '../../widgets/button_main.dart';

class PurchaseMain extends StatefulWidget {
  const PurchaseMain({super.key});

  @override
  State<PurchaseMain> createState() => _PurchaseMainState();
}

class _PurchaseMainState extends State<PurchaseMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //       backgroundColor: AColors.MediumSeaGreen,
          title: const Text(
            "المشتريات",
            style: TextStyle(
              fontFamily: 'Arial',
              //   fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 10,
              child: Divider(thickness: 1, color: notUpdtblColor),
            ),
            Container(
                //    height: 100,
                child: const Text(
              "صفحة المشتريات",
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ButtonMain(
                      fontSize: 14,
                      text: "اضافة المشتريات",
                      onPressed: () {
                        Get.toNamed('/purchase/add');
                      }),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ButtonMain(
                      fontSize: 14,
                      text: "مشتريات معلقة",
                      onPressed: () {
                        Get.toNamed('/purchase/temp');
                      }),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ButtonMain(
                      fontSize: 14,
                      text: "قائمة المشتريات",
                      onPressed: () {
                        Get.toNamed('/purchase/list');
                      }),
                )),
              ],
            ),
          ]),
        ));
  }
}
