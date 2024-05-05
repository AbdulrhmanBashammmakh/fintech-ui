import 'package:fintech/utils/AColors.dart';
import 'package:fintech/views/Ledger/ledger-controller.dart';
import 'package:fintech/widgets/button_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LedgerScreen extends StatelessWidget {
  LedgerScreen({super.key});

  Widget detailsInvoice(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width * 0.6;
    final controller = Get.find<LedgerController>();
    return GetBuilder<LedgerController>(
        init: controller,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (context, index) => Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.list[index].id.toString()),
                          Text(controller.list[index].name.toString()),
                          Text(controller.list[index].amount.toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.list[index].from.toString()),
                          Text(controller.list[index].to.toString()),
                          Text(controller.list[index].opts.toString()),
                          Text(controller.list[index].createdAt.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ]),
              ),
            ),
          );
        });

    // return GetBuilder<LedgerController>(
    //   builder: (controller) {
    //     return ListView(
    //       children: <Widget>[
    //         Container(
    //           //  height: 40,
    //           width: mdw - 20,
    //           child: Card(child: Center(child: Text("det-trans".tr))),
    //           padding: const EdgeInsets.all(5),
    //           margin: const EdgeInsets.all(5),
    //         ),
    //         Container(
    //           padding: const EdgeInsets.all(5),
    //           margin: const EdgeInsets.all(5),
    //           //  width: mdw,
    //           child: Center(
    //             child: ListView.builder(
    //               itemCount: controller.list.length,
    //               itemBuilder: (context, index) => Card(
    //                 child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(controller.list[index].id.toString()),
    //                           Text(controller.list[index].name.toString()),
    //                           Text(controller.list[index].amount.toString()),
    //                           Text(controller.list[index].from.toString()),
    //                           Text(controller.list[index].to.toString()),
    //                           Text(controller.list[index].opts.toString()),
    //                           Text(controller.list[index].createdAt.toString()),
    //                         ],
    //                       )
    //                     ]),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          //   backgroundColor: AColors.FireBrick,
          title: Text(
            "ledger".tr,
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
                        fontSize: 15,
                        text: 'home-page'.tr,
                        icon: Icons.home,
                        onClicked: () {
                          Get.offNamed('/');
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
                        onClicked: () {
                          Get.offNamed('/');
                        },
                      )),
                ),
              ],
            ),
            Divider(thickness: 1, color: notUpdtblColor),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    height: mdh * .9,
                    width: mdw * 2 / 3,
                    child: Card(
                      color: AColors.Silver,
                      child: detailsInvoice(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
