import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/AColors.dart';
import '../../widgets/button_main.dart';

class ExpensesMain extends StatefulWidget {
  const ExpensesMain({super.key});

  @override
  State<ExpensesMain> createState() => _ExpensesMainState();
}

class _ExpensesMainState extends State<ExpensesMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //   backgroundColor: AColors.FireBrick,
          title: Text(
            "expenses".tr,
            style: TextStyle(
              fontFamily: 'Arial',
              //   fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
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
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: ButtonWidget(
                        text: 'back'.tr,
                        icon: Icons.arrow_back,
                        onClicked: () {},
                      )),
                ),
              ],
            ),
            Divider(thickness: 1, color: notUpdtblColor),
          ],
        ));
  }
}
