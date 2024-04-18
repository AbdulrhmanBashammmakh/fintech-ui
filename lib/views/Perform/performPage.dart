import 'package:fintech/utils/AColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerformMain extends StatefulWidget {
  const PerformMain({super.key});

  @override
  State<PerformMain> createState() => _PerformMainState();
}

class _PerformMainState extends State<PerformMain> {
  @override
  Widget build(BuildContext context) {
    var md = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AColors.CornflowerBlue,
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
              "صفحة التهيئة",
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )),
            // Container(
            //   width: md / 2,
            //   padding: const EdgeInsets.all(15),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateColor.resolveWith(
            //             (states) => AColors.CornflowerBlue)),
            //     onPressed: () async {},
            //     child: const Text(
            //       'المبيعات',
            //       style: TextStyle(
            //         fontFamily: 'Arial',
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: md / 2,
            //   padding: const EdgeInsets.all(15),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateColor.resolveWith(
            //             (states) => AColors.CornflowerBlue)),
            //     onPressed: () async {},
            //     child: const Text(
            //       'المبيعات',
            //       style: TextStyle(
            //         fontFamily: 'Arial',
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: md / 2,
            //   padding: const EdgeInsets.all(15),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateColor.resolveWith(
            //             (states) => AColors.CornflowerBlue)),
            //     onPressed: () async {},
            //     child: const Text(
            //       'المبيعات',
            //       style: TextStyle(
            //         fontFamily: 'Arial',
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: md / 2,
            //   padding: const EdgeInsets.all(15),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateColor.resolveWith(
            //             (states) => AColors.CornflowerBlue)),
            //     onPressed: () async {},
            //     child: const Text(
            //       'المبيعات',
            //       style: TextStyle(
            //         fontFamily: 'Arial',
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AColors.CornflowerBlue)),
                    onPressed: () async {},
                    child: Text(
                      'accounts'.tr,
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AColors.CornflowerBlue)),
                    onPressed: () async {},
                    child: Text(
                      'units'.tr,
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AColors.CornflowerBlue)),
                    onPressed: () async {
                      // Get.toNamed('/');
                    },
                    child: Text(
                      'cates'.tr,
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
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AColors.CornflowerBlue)),
                    onPressed: () async {},
                    child: Text(
                      'vendors'.tr,
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
                Spacer(),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AColors.CornflowerBlue)),
                    onPressed: () async {
                      Get.toNamed('/');
                    },
                    child: const Text(
                      'الرجوع',
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
          ]),
        ));
  }
}
