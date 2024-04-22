import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../utils/AColors.dart';
import '../../widgets/button_main.dart';

class ExpensesMain extends StatefulWidget {
  const ExpensesMain({super.key});

  @override
  State<ExpensesMain> createState() => _ExpensesMainState();
}

class _ExpensesMainState extends State<ExpensesMain> {
  Future<ResponseObject>? vendorDataFuture;
  List<RepRow> list = [];
  List<String> columns = [
    // 'update'.tr,
    // 'delete'.tr,
    'id'.tr,
    'phone'.tr,
    'name'.tr,
    'address'.tr,
    'active'.tr,
    'createdAt'.tr,
  ];

  TextEditingController disController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController dateInvoiceController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  final BoxDecoration sliderDecoration = BoxDecoration(
      color: constPrimaryColor.withOpacity(0.7),
      borderRadius: const BorderRadius.all(Radius.circular(20)));
  final BoxDecoration sliderActiveDecoration = BoxDecoration(
      color: constPrimaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)));
  final underDecoration = BoxDecoration(
      color: constPrimaryColor.withOpacity(0.3),
      borderRadius: const BorderRadius.all(Radius.circular(12.0)));
  final double scrollWidth = 12;
  bool isAscending = false;
  int? sortColumnIndex;
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Expanded(
                child: Text(column,
                    textAlign:
                        TextAlign.center)), //Center(child: Text(column)),
            // onSort: onSort,
          ))
      .toList();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vendorDataFuture = getInvRequestPost(
          fullUrl: "http://localhost:9098/myapp238/api/v1/main/vendor/all");
      getaAll();
      setState(() {});
    });

    super.initState();
  }

  getaAll() async {
    try {
      final value = await vendorDataFuture;
      final value2 = value?.data.rep!.toList();
      value2?.forEach((e) {
        list.add(RepRow(
            name: e.name,
            id: e.id,
            active: e.active,
            type: e.type,
            createdAt: e.createdAt,
            address: e.address,
            phone: e.phone,
            from: e.from,
            to: e.to,
            opts: e.opts,
            amount: e.amount));
      });
      setState(() {});
      debugPrint("${list.length}");
    } catch (e) {
      debugPrint("sth RepRow");
    }
  }

  ElevatedButton confirmButton({createdAt, id, name, phone, add}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        debugPrint("$id");
        // var det = await getDetSaleRequest(parm: id);
        idController.text = id.toString();
        dateInvoiceController.text = createdAt;
        addressController.text = add.toString();
        vendorController.text = name;
        phoneController.text = phone;
        dismissDialog(context: context);
        // list = det.data.rep!;
        setState(() {});
      },
    );
  }

  Widget detailsInvoice() {
    var mdw = MediaQuery.of(context).size.width * 0.9;
    return ListView(
      children: [
        Container(
          height: 40,
          width: mdw / 2,
          child: Card(child: Center(child: Text("det-expenses".tr))),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          //  width: mdw,
          child: Center(
            child: Card(
              child: AdaptiveScrollbar(
                controller: _verticalScrollController,
                width: scrollWidth,
                scrollToClickDelta: 75,
                scrollToClickFirstDelay: 200,
                scrollToClickOtherDelay: 50,
                sliderDecoration: sliderDecoration,
                sliderActiveDecoration: sliderActiveDecoration,
                underDecoration: underDecoration,
                child: AdaptiveScrollbar(
                  controller: _horizontalScrollController,
                  underSpacing: EdgeInsets.only(bottom: scrollWidth),
                  width: scrollWidth,
                  position: ScrollbarPosition.bottom,
                  sliderDecoration: sliderDecoration,
                  sliderActiveDecoration: sliderActiveDecoration,
                  underDecoration: underDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            controller: _verticalScrollController,
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              controller: _horizontalScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: scrollWidth),
                                child: DataTable(
                                  showBottomBorder: true,
                                  sortAscending: isAscending,
                                  sortColumnIndex: sortColumnIndex,
                                  columns: getColumns(columns),
                                  horizontalMargin: 10,
                                  rows: list
                                      .map(
                                        (data) => DataRow(
                                          cells: <DataCell>[
                                            // DataCell(ElevatedButton(
                                            //     onPressed: () {
                                            //       list.remove(data);
                                            //
                                            //       setState(() {});
                                            //     },
                                            //     style: ButtonStyle(
                                            //       backgroundColor:
                                            //           MaterialStateProperty.all(
                                            //               secondaryColor),
                                            //     ),
                                            //     child: Text('delete'.tr))),
                                            DataCell(Text(data.id.toString())),
                                            DataCell(Text(data.phone)),
                                            DataCell(Text(data.name)),
                                            DataCell(Text(data.address)),
                                            DataCell(
                                                Text(data.active.toString())),
                                            DataCell(Text(data.createdAt)),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
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
                        onClicked: () {
                          Get.toNamed('/');
                        },
                      )),
                ),
              ],
            ),
            Divider(thickness: 1, color: notUpdtblColor),
            Row(
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                child: ButtonWidget(
                                  text: 'add-expenses'.tr,
                                  icon: Icons.add_box_sharp,
                                  onClicked: () {},
                                )),
                          ],
                        ))),
                Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                height: 400,
                                width: mdw,
                                child: Card(
                                  color: AColors.Silver,
                                  child: detailsInvoice(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
