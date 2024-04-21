import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fintech/models/Models.dart';
import 'package:fintech/utils/AColors.dart';
import 'package:fintech/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/BaseModel.dart';
import '../../utils/AjustScroll.dart' as h;
import '../../widgets/button_main.dart';

class PurchasesList extends StatefulWidget {
  const PurchasesList({super.key});

  @override
  State<PurchasesList> createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  final ScrollController verticalScrollController = ScrollController();
  Future<ResponseObject>? _unitsDataFuture;
  Future<ResponseObject>? _units;
  Future<ResponseObject>? _vendorsDataFuture;
  Future<ResponseObject>? _catesDataFuture;
  String urlUnit = ApiEndPoint.URL + ApiEndPoint.UnitMainAll;
  String urlVendor = ApiEndPoint.URL + ApiEndPoint.VendorMainAll;
  String urlCate = ApiEndPoint.URL + ApiEndPoint.CateMainAll;
  List<PchDet> list = [];
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
      _unitsDataFuture = getInvRequestVer();

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
      final value = await _catesDataFuture;
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
  }

  ElevatedButton confirmButton({createdAt, id, vendorId, state, total}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        var det = await getDetPchRequest(parm: id);
        debugPrint("${det.data.pchDets!.length}");
        debugPrint("${id}");
        dateInvoiceController.text = createdAt;
        // var ven = getVendor();
        vendorController.text = vendorId;
        //   stateController.text = state == 0 ? "مؤقته" : "معتمدة";
        amountController.text = total.toString();
        dismissDialog(context: context);
        list = det.data.pchDets!;
        setState(() {});
      },
    );
  }

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
            child: Card(child: Center(child: Text("تفاصيل الفاتورة"))),
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
                child: Text("قيمة الفاتورة"),
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
            "pch-list-ver".tr,
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
                            final units = (snapshot.data!.data.heads ?? []);
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
                                              vendorId: unit.vendor,
                                              state: unit.temp,
                                              total: unit.total,
                                              id: unit.temp,
                                              createdAt: unit.createdAt),
                                          dialogType: "Q",
                                          title: "do-show-invoice".tr,
                                          desc: "${'number'.tr}${unit.id} ",
                                        );

                                        setState(() {});
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          child: ListTile(
                                            title: Text(
                                                '${unit.total} ${'rial'.tr}'),
                                            subtitle: Text(unit.vendor),
                                            trailing: Text(unit.id.toString()),
                                            leading: Icon(
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
            ),
          ],
        ));
  }
}
