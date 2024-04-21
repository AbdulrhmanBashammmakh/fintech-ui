import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fintech/utils/AColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/Sale.dart';
import '../../utils/AjustScroll.dart' as h;
import '../../widgets/button_main.dart';

class SaleList extends StatefulWidget {
  const SaleList({super.key});

  @override
  State<SaleList> createState() => _SaleListState();
}

class _SaleListState extends State<SaleList> {
  Future<ResponseObject>? saleDataFuture;
  Future<List<SaleHead>?>? listOfSale;
  List<SaleDet> list = [];
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
  TextEditingController disController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController stateController = TextEditingController();
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
      saleDataFuture = getInvRequestPost(
          fullUrl: "http://localhost:9098/myapp238/api/v1/sale/all");

      setState(() {});
    });

    super.initState();
  }

  ElevatedButton confirmButton({createdAt, id, customer, disc, total}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        debugPrint("$id");
        var det = await getDetSaleRequest(parm: id);
        idController.text = id.toString();
        dateInvoiceController.text = createdAt.toString();
        amountController.text = total.toString();
        customerController.text = customer;
        disController.text = disc;
        dismissDialog(context: context);
        list = det.data.saleDet!;
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
                                          DataCell(Text(data.product)),
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
                      controller: disController,
                      decoration: InputDecoration(
                        label: Text("discount".tr),
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
            "sale".tr,
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
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  child: FutureBuilder<ResponseObject>(
                    future: saleDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final units =
                            (snapshot.data!.data.saleHead ?? []).toList();
                        debugPrint("reply ${units.length}");
                        return units.isEmpty
                            ? Card(
                                child: Center(
                                    child: Container(
                                        child: Text("not-things".tr))),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: verticalScrollController,
                                child: Container(
                                  height: mdh - 100,
                                  child: ListView.builder(
                                    //reverse: true,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: units.length,
                                    controller:
                                        h.AdjustableScrollController(80),
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final unit = units[index];
                                      //  debugPrint("reply ${unit.total}");
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
                                                customer: unit.customer,
                                                total: unit.total,
                                                disc: unit.discount.toString(),
                                                id: unit.id,
                                                createdAt: unit.createdAt),
                                            dialogType: "Q",
                                            title: "do-show-invoice".tr,
                                            desc: "${'number'.tr}${unit.id} ",
                                          );

                                          // setState(() {});
                                        },
                                        child: Card(
                                            child: ListTile(
                                          title: Text(
                                              '${unit.total} ${'rial'.tr}'),
                                          subtitle: Text(unit.createdAt),
                                          trailing: Text(unit.id.toString()),
                                          leading:
                                              Icon(Icons.credit_score_rounded),
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
                )),
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
