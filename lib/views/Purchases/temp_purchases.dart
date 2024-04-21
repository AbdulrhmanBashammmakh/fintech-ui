import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fintech/models/Models.dart';
import 'package:fintech/utils/AColors.dart';
import 'package:fintech/utils/Constants.dart';
import 'package:fintech/views/Purchases/purchase_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/BaseModel.dart';
import '../../utils/AjustScroll.dart' as h;
import '../../widgets/button_main.dart';

class PurchasesTemp extends StatefulWidget {
  const PurchasesTemp({super.key});

  @override
  State<PurchasesTemp> createState() => _PurchasesTempState();
}

class _PurchasesTempState extends State<PurchasesTemp> {
  final ScrollController verticalScrollController = ScrollController();

  Future<ResponseObject>? _unitsDataFuture;
  Future<ResponseObject>? _units;
  Future<ResponseObject>? _vendorsDataFuture;
  Future<ResponseObject>? _catesDataFuture;
  bool showVerified = false;
  String urlUnit = ApiEndPoint.URL + ApiEndPoint.UnitMainAll;
  String urlVendor = ApiEndPoint.URL + ApiEndPoint.VendorMainAll;
  String urlCate = ApiEndPoint.URL + ApiEndPoint.CateMainAll;
  List<TempDet> list = [];
  List<String> columns = [
    // 'update'.tr,
    // 'delete'.tr,
    'cate'.tr,
    'code'.tr,
    'name-product'.tr,
    'qty'.tr,
    'price'.tr,
    'amount'.tr,
    'unit'.tr,
    'barcode'.tr,
  ];

  TextEditingController amountController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController dateInvoiceController = TextEditingController();
  TextEditingController idController = TextEditingController();

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

  List<BaseModel> uList = <BaseModel>[];
  List<BaseModel> cateList = <BaseModel>[];
  List<BaseModel> vendorList = <BaseModel>[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _unitsDataFuture = getInvRequest(
          fullUrl: "http://localhost:9098/myapp238/api/v1/temp/all");

      _units = getAllMainRequest(fullUrl: urlUnit);
      _vendorsDataFuture = getAllMainRequest(fullUrl: urlVendor);
      _catesDataFuture = getAllMainRequest(fullUrl: urlCate);
      getaAll();

      setState(() {});
    });

    super.initState();
  }

  getaAll() async {
    try {
      final value = await _unitsDataFuture;
      final value2 = value?.data.rep!.toList();
      value2?.forEach((e) {
        cateList.add(BaseModel(id: e.id, name: e.name));
      });
      debugPrint("${cateList.length}");
    } catch (e) {
      debugPrint("sth cates");
    }

    try {
      final value = await _vendorsDataFuture;
      final value2 = value?.data.rep!.toList();
      value2?.forEach((e) {
        vendorList.add(BaseModel(id: e.id, name: e.name));
      });
      debugPrint("${vendorList.length}");
    } catch (e) {
      debugPrint("sth cates");
    }
    try {
      final value = await _units;
      final value2 = value?.data.rep!.toList();
      value2?.forEach((e) {
        uList.add(BaseModel(id: e.id, name: e.name));
      });
      debugPrint("${uList.length}");
    } catch (e) {
      debugPrint("sth cates");
    }

    // _vendorsDataFuture?.then((value) => value.data.rep?.forEach((e) {
    //       vendorList.add(BaseModel(id: e.id, name: e.name));
    //     }));
    //
    // _units?.then((value) => value.data.rep?.forEach((e) {
    //       uList.add(BaseModel(id: e.id, name: e.name));
    //       debugPrint("${e.name}");
    //     }));
    //
    // debugPrint("${uList.length}");
    // _catesDataFuture?.then((value) => value.data.rep?.forEach((e) {
    //       cateList.add(BaseModel(id: e.id, name: e.name));
    //     }));
  }

  ElevatedButton confirmButton({createdAt, id, vendorId, state, total}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        debugPrint("$id");
        var det = await getDetTempRequest(parm: id);
        // det.data.dets!.length;
        idController.text = id.toString();
        debugPrint("${det.data.dets!.length}");
        dateInvoiceController.text = createdAt;
        var ven = getVendor(vendorId);
        vendorController.text = ven;
        stateController.text = state == 0 ? "مؤقته" : "معتمدة";
        state == 0 ? showVerified = true : showVerified = false;
        amountController.text = total.toString();
        dismissDialog(context: context);
        list = det.data.dets!;
        setState(() {});
      },
    );
  }

  // String getCate(int id) {
  //   if (id > 0) {
  //     BaseModel x = cateList.where((e) => e.id == id).first;
  //     if (x.name.isEmpty) {
  //       return "";
  //     } else {
  //       return x.name;
  //     }
  //   }
  //   return '';
  // }

  String getVendor(int id) {
    if (id > 0) {
      BaseModel x = vendorList.where((e) => e.id == id).first;
      if (x.name.isEmpty) {
        return "";
      } else {
        return x.name;
      }
    }
    return '';
  }

  // String getUnit(int id) {
  //   if (id > 0) {
  //     BaseModel x = uList.where((e) => e.id == id).first;
  //     if (x.name.isEmpty) {
  //       return "";
  //     } else {
  //       return x.name;
  //     }
  //   }
  //   return '';
  // }

  Widget detailsInvoice() {
    var mdw = MediaQuery.of(context).size.width * 0.9;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      //  width: mdw,
      child: ListView(
        children: [
          Container(
            height: 40,
            width: mdw / 2,
            child: Card(child: Center(child: Text("det-invoice".tr))),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
          ),
          Card(
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: scrollWidth),
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
                                          DataCell(Text(data.cate.toString())),
                                          DataCell(Text(data.code)),
                                          DataCell(Text(data.name)),
                                          DataCell(Text(data.qty.toString())),
                                          DataCell(Text(data.price.toString())),
                                          DataCell(Text(data.amt.toString())),
                                          DataCell(Text(data.unit.toString())),
                                          DataCell(Text(data.code)),
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
        ],
      ),
    );
  }

  Widget headInvoice() {
    var mdw = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        child: Card(
          child: ListView(
            children: <Widget>[
              Container(
                child: Text("value-invoice".tr),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      enabled: false,
                      controller: amountController,
                      decoration: InputDecoration(
                        label: Text("invoice-total".tr),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      enabled: false,
                      controller: stateController,
                      decoration: InputDecoration(
                        label: Text("state".tr),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      enabled: false,
                      controller: vendorController,
                      decoration: InputDecoration(
                        label: Text("vendor".tr),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      enabled: false,
                      controller: dateInvoiceController,
                      decoration: InputDecoration(
                        label: Text("date".tr),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
              ]),
              Center(
                child: showVerified
                    ? Container(
                        width: mdw / 3,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: ButtonWidget(
                            text: "verified".tr,
                            icon: Icons.verified_outlined,
                            onClicked: () async {
                              int x = await sendPostRequestVer(
                                  discount: 0,
                                  temp: int.parse(idController.text));
                              if (x == 1) {
                                Get.off(() => PurchaseMain());
                              }
                            }),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          //       backgroundColor: AColors.MediumSeaGreen,
          title: Text(
            "ver-invoice-temp".tr,
            style: const TextStyle(
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
                          Get.toNamed('/purchase');
                        },
                      )),
                ),
              ],
            ),
            Divider(thickness: 1, color: notUpdtblColor),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: FutureBuilder<ResponseObject>(
                        future: _unitsDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final units = (snapshot.data!.data.invs ?? []);
                            return SingleChildScrollView(
                              controller: verticalScrollController,
                              scrollDirection: Axis.vertical,
                              child: Container(
                                height: mdh - 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  controller: h.AdjustableScrollController(80),
                                  itemCount: units.length,
                                  itemBuilder: (context, index) {
                                    final unit = units[index];
                                    //debugPrint("reply ${unit.name}");
                                    return GestureDetector(
                                      onTap: () {
                                        show_Dialog(
                                          context: context,
                                          cancelPress: () {
                                            dismissDialog();
                                          },
                                          btnOkText: "ok".tr,
                                          btnCancelText: 'cancel'.tr,
                                          btnOk: confirmButton(
                                              vendorId: unit.vendorId,
                                              state: unit.state,
                                              total: unit.total,
                                              id: unit.id,
                                              createdAt: unit.createdAt),
                                          dialogType: "Q",
                                          title: "do-show-invoice".tr,
                                          desc: "${'number'.tr}${unit.id} ",
                                        );

                                        setState(() {
                                          units[index].isSelected =
                                              !units[index].isSelected;
                                        });
                                      },
                                      child: Card(
                                          color: unit.state == 1
                                              ? Colors.blue
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                                '${unit.total} ${'rial'.tr}'),
                                            subtitle: Text(unit.createdAt),
                                            trailing: Text(unit.id.toString()),
                                            leading: unit.state == 0
                                                ? Icon(Icons.add)
                                                : Icon(
                                                    Icons.credit_score_rounded),
                                          )),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("sth-wrong".tr));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            height: mdh / 4.5,
                            width: mdw,
                            child: Card(
                              color: AColors.Silver,
                              child: headInvoice(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            height: mdh - (mdh / 4) - 100,
                            width: mdw,
                            child: Card(
                              color: AColors.Silver,
                              child: detailsInvoice(),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
          // child: ,
        ));
  }
}
