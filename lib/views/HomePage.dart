import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/AColors.dart';
import '../widgets/button_main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "اهلا بكم",
            style: TextStyle(
              fontFamily: 'Arial',
              //   fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                //    height: 100,
                child: const Text(
              "الصفحة الرئيسية",
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
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('/sale');
                    },
                    child: const Text(
                      'المبيعات',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('/stock');
                    },
                    child: const Text(
                      'المخزون',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ButtonMain(
                      fontSize: 14,
                      text: "المشتريات",
                      onPressed: () {
                        Get.toNamed('/purchase');
                      }),
                )),
              ],
            ),
            SizedBox(
              height: 10,
              child: Divider(thickness: 1, color: notUpdtblColor),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('/perform');
                    },
                    child: const Text(
                      'التهيئة',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('/ledger');
                    },
                    child: const Text(
                      'السجل',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('/expenses');
                    },
                    child: Text(
                      'expenses'.tr,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 10,
              child: Divider(thickness: 1, color: notUpdtblColor),
            ),
          ]),
        ));
  }
}
// Text("hello");
