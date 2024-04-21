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
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: ButtonWidget(
                        text: 'home-page'.tr,
                        icon: Icons.home,
                        onClicked: () {
                          Get.toNamed('/');
                          //  Get.to('/');
                        },
                      )),
                ),
                Expanded(child: SizedBox()),
                Expanded(child: SizedBox()),
                Expanded(child: SizedBox()),
                // Expanded(
                //   child: Container(
                //       padding: const EdgeInsets.all(5),
                //       margin: const EdgeInsets.all(5),
                //       child: ButtonWidget(
                //         text: 'back'.tr,
                //         icon: Icons.arrow_back,
                //         onClicked: () {
                //           Get.toNamed('/purchase');
                //         },
                //       )),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
              child: Divider(thickness: 1, color: notUpdtblColor),
            ),
            Container(
                //    height: 100,
                child: Text(
              "pch-page".tr,
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
                      text: "pch-add".tr,
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
                      text: "pch-temp".tr,
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
                      text: "pch-list-ver".tr,
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
