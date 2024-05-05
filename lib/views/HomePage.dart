import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/AjustScroll.dart' as h;
import '../utils/AColors.dart';
import '../widgets/section_card.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "اهلا بكم",
//             style: TextStyle(
//               fontFamily: 'Arial',
//               //   fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: Center(
//           child: Column(children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//                 //    height: 100,
//                 child: const Text(
//               "الصفحة الرئيسية",
//               style: TextStyle(
//                 fontFamily: 'Arial',
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Get.toNamed('/sale');
//                     },
//                     child: const Text(
//                       'المبيعات',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Get.toNamed('/stock');
//                     },
//                     child: const Text(
//                       'المخزون',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ButtonMain(
//                       fontSize: 14,
//                       text: "المشتريات",
//                       onPressed: () {
//                         Get.toNamed('/purchase');
//                       }),
//                 )),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//               child: Divider(thickness: 1, color: notUpdtblColor),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Get.toNamed('/perform');
//                     },
//                     child: const Text(
//                       'التهيئة',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Get.toNamed('/ledger');
//                     },
//                     child: const Text(
//                       'السجل',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Get.toNamed('/expenses');
//                     },
//                     child: Text(
//                       'expenses'.tr,
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//               child: Divider(thickness: 1, color: notUpdtblColor),
//             ),
//           ]),
//         ));
//   }
// }

class Home extends StatelessWidget {
  Home({super.key});

//var x=Get.put
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("parts-shop".tr),
        centerTitle: false,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       //  Scaffold.of(context).openDrawer();
          //     },
          //     icon: Icon(Icons.menu))
        ],
      ),
      body: HomeBody(),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('الاعدادات'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: primaryColor),
              title: Text('تسجيل دخول'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.engineering, color: primaryColor),
              title: Text('طلب تسجيل كمهندس'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.insert_link_outlined, color: primaryColor),
              title: Text('من نحن'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.phone, color: primaryColor),
              title: Text('تواصل معنا'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  TextEditingController searchBarController = TextEditingController();
  List icons = [
    Icons.shopping_basket_outlined,
    Icons.outbox_rounded,
    Icons.search_outlined,
    Icons.settings_suggest_outlined,
    Icons.local_offer_outlined
  ];
  List titles = ["cart".tr, "order".tr, "search".tr, "suggest".tr, "offer".tr];
  List<MainTitle> mains = [
    MainTitle(
        title: 'sale'.tr,
        subTitle: 'sale'.tr,
        goto: '/sale',
        img: 'assets/images/teleyemen.png'),
    MainTitle(
        title: 'stock'.tr,
        subTitle: 'stock'.tr,
        goto: '/stock',
        img: 'assets/images/htfy.png'),
    MainTitle(
        title: 'purchase'.tr,
        subTitle: 'purchase'.tr,
        goto: '/purchase',
        img: 'assets/images/aden_net.png'),
    MainTitle(
        title: 'ledger'.tr,
        subTitle: 'ledger'.tr,
        goto: '/ledger',
        img: 'assets/images/YTelecom.png'),
    MainTitle(
        title: 'expenses'.tr,
        subTitle: 'expenses'.tr,
        goto: '/expenses',
        img: 'assets/images/yemen_mobile.png'),
    MainTitle(
        title: 'perform'.tr,
        subTitle: 'perform'.tr,
        goto: '/perform',
        img: 'assets/images/sabafon.png'),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      constraints: BoxConstraints(minWidth: 600),
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          size.width > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          // color: backgroundColor,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(5),
                          child: TextFormField(
                            controller: searchBarController,
                            decoration: InputDecoration(
                              //   prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(Icons.search),
                              //   icon: Icon(Icons.search),
                              label: Text("Search"),
                              counterText: "",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding / 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                            // color: Colors.white,
                            height: MediaQuery.of(context).size.height * .18,
                            // width: size.width - 200,
                            child: ListView.separated(
                              itemCount: titles.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return sectionCard(
                                    ic: icons[index], tit: titles[index]);
                              },
                            )

                            // ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: titles.length,
                            //     itemBuilder: (context, index) {
                            //       return sectionCard(ic: icons[index], tit: titles[index]);
                            //     }),
                            ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        // color: backgroundColor,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: searchBarController,
                          decoration: InputDecoration(
                            //   prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.search),
                            //   icon: Icon(Icons.search),
                            label: Text("Search"),
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        child: Container(
                            // color: Colors.white,
                            height: MediaQuery.of(context).size.height * .18,
                            // width: size.width - 200,
                            child: ListView.separated(
                              itemCount: titles.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 20.0),
                              itemBuilder: (BuildContext context, int index) {
                                return sectionCard(
                                    ic: icons[index], tit: titles[index]);
                              },
                            )

                            // ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: titles.length,
                            //     itemBuilder: (context, index) {
                            //       return sectionCard(ic: icons[index], tit: titles[index]);
                            //     }),
                            ),
                      ),
                    ),
                  ],
                ),
          Expanded(
              child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              size.width > 800
                  ? size.width > 1000
                      ? GridView.builder(
                          itemCount: mains.length,
                          controller: h.AdjustableScrollController(80),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) => ProductContainer(
                                index: index,
                                mainTitle: mains[index],
                              ))
                      : GridView.builder(
                          itemCount: mains.length,
                          controller: h.AdjustableScrollController(80),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => ProductContainer(
                                index: index,
                                mainTitle: mains[index],
                              ))
                  : ListView.builder(
                      itemCount: mains.length,
                      controller: h.AdjustableScrollController(80),
                      itemBuilder: (context, index) => ProductContainer(
                            index: index,
                            mainTitle: mains[index],
                          )),
            ],
          )),
          // Expanded(
          //     child: Stack(
          //   children: [
          //     Container(
          //       margin: EdgeInsets.only(top: 70),
          //       decoration: BoxDecoration(
          //           color: backgroundColor,
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(40),
          //               topRight: Radius.circular(40))),
          //     ),
          //     Container(
          //       color: Colors.white,
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: Container(
          //               padding: EdgeInsets.all(20),
          //               margin: EdgeInsets.all(10),
          //               child: ElevatedButton(
          //                   child: Text("ابحث برقم القطعه"), onPressed: () {}),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(22)),
          //             ),
          //           ),
          //           Expanded(
          //             child: Container(
          //               padding: EdgeInsets.all(20),
          //               margin: EdgeInsets.all(10),
          //               child: ElevatedButton(
          //                   child: Text("ابحث برقم القطعه"), onPressed: () {}),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(22)),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // )),

          // Container(
          //   color: primaryColor,
          //   child: Row(
          //     children: [
          //       // Expanded(
          //       //   child: Container(
          //       //     padding: EdgeInsets.all(20),
          //       //     margin: EdgeInsets.all(10),
          //       //     child: ElevatedButton(
          //       //         child: Text("ابحث برقم القطعه",
          //       //             style: TextStyle(fontSize: 12)),
          //       //         onPressed: () {}),
          //       //     decoration:
          //       //         BoxDecoration(borderRadius: BorderRadius.circular(22)),
          //       //   ),
          //       // ),
          //       // Expanded(
          //       //   child: Container(
          //       //     padding: EdgeInsets.all(20),
          //       //     margin: EdgeInsets.all(10),
          //       //     child: ElevatedButton(
          //       //         child:
          //       //             Text("طلب توفير قطع", style: TextStyle(fontSize: 12)),
          //       //         onPressed: () {}),
          //       //     decoration:
          //       //         BoxDecoration(borderRadius: BorderRadius.circular(22)),
          //       //   ),
          //       // ),
          //       Expanded(
          //         child: Container(
          //           padding: EdgeInsets.all(10),
          //           margin: EdgeInsets.all(10),
          //           child: IconButton(
          //               icon: Icon(Icons.send_and_archive_outlined,
          //                   color: Colors.white),
          //               onPressed: () {}),
          //           decoration:
          //               BoxDecoration(borderRadius: BorderRadius.circular(22)),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           padding: EdgeInsets.all(10),
          //           margin: EdgeInsets.all(10),
          //           child: IconButton(
          //               icon: Icon(Icons.add_shopping_cart, color: Colors.white),
          //               onPressed: () {}),
          //           decoration:
          //               BoxDecoration(borderRadius: BorderRadius.circular(22)),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           padding: EdgeInsets.all(10),
          //           margin: EdgeInsets.all(10),
          //           child: IconButton(
          //               icon: Icon(Icons.query_stats, color: Colors.white),
          //               onPressed: () {}),
          //           decoration:
          //               BoxDecoration(borderRadius: BorderRadius.circular(22)),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    ));
  }
}

class ProductContainer extends StatelessWidget {
  ProductContainer({super.key, required this.index, required this.mainTitle});

  final int index;
  final MainTitle mainTitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      height: 190,
      // color: secondaryColor,
      child: InkWell(
        onTap: () {
          Get.toNamed(mainTitle.goto);
        },
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            height: 166,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: textColor,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ]),
          ),
          Positioned(
              top: 0.0,
              left: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                width: 200,
                child: Image.asset(mainTitle.img),
              )),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 136,
                width: size.width - 200,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Text(mainTitle.title,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Text(mainTitle.subTitle,
                            style: Theme.of(context).textTheme.caption),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 1.5,
                              vertical: kDefaultPadding / 5),
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(22)),
                          child: Text("press-here".tr,
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ]),
              ))
        ]),
      ),
    );
  }
}

class MainTitle {
  MainTitle(
      {this.img = 'assets/images/you.png',
      required this.title,
      required this.subTitle,
      required this.goto});
  final String goto;
  final String img;
  final String title;
  final String subTitle;
}
