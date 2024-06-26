import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/Models.dart';
import '../../utils/AColors.dart';
import '../../utils/AjustScroll.dart' as h;
import '../../widgets/button_main.dart';

class StockMain extends StatefulWidget {
  const StockMain({super.key});

  @override
  State<StockMain> createState() => _StockMainState();
}

class _StockMainState extends State<StockMain> {
  List<MainStock> list = [];
  List<MainStock> listAva = [];
  List<MainStock> listNoPrice = [];
  List<MainStock> listNonAva = [];
  Future<ResponseObject>? stockListAva;
  Future<ResponseObject>? stockListNoPrice;
  Future<ResponseObject>? stockListNonAva;
  GlobalKey<FormState> dataEntryFormState = GlobalKey<FormState>();
  int ret = 0;
  TextEditingController newPriceController = TextEditingController();
  TextEditingController newCostController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  int selected = 0;
  int itr = 1;
  int itrNon = 1;
  int itrNonPrice = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        stockListAva = getInvRequestPost(
            fullUrl: "http://localhost:9098/myapp238/api/v1/stock/available"),
        stockListNonAva = getInvRequestPost(
            fullUrl:
                "http://localhost:9098/myapp238/api/v1/stock/no-available"),
        stockListNoPrice = getInvRequestPost(
            fullUrl: "http://localhost:9098/myapp238/api/v1/stock/no-price"),
      ]);
      getAva();
      getNonAva();
      getNonPrice();
      setState(() {});
    });

    super.initState();
  }

  getAddNewItem(context) {
    ret = 0;
    return Form(
        key: dataEntryFormState,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: Text(
                'add-cate'.tr,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text("product".tr),
                        counterText: "",
                      ),
                      enabled: false,
                      validator: (text) {
                        if (text == '') return "required".tr;
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: lastController,
                      decoration: InputDecoration(
                        label: Text("last-buy".tr),
                        counterText: "",
                      ),
                      enabled: false,
                      validator: (text) {
                        if (text == '') return "required".tr;
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: newCostController,
                      decoration: InputDecoration(
                        label: Text("new-cost".tr),
                        counterText: "",
                      ),
                      validator: (text) {
                        if (text == '') return "required".tr;
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: newPriceController,
                      decoration: InputDecoration(
                        label: Text("new-price".tr),
                        counterText: "",
                      ),
                      validator: (text) {
                        if (text == '') return "required".tr;
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: ButtonWidget(
                        text: "update".tr,
                        icon: Icons.add,
                        onClicked: () async {
                          if (dataEntryFormState.currentState!.validate()) {
                            UpdatePrice update = UpdatePrice(
                                id: int.parse(idController.text),
                                cost: double.parse(newCostController.text),
                                price: double.parse(newPriceController.text));
                            ret =
                                await sendPostUpdatePrice(updatePrice: update);
                            setState(() {});
                            dismissDialog(context: context);
                            if (ret == 1) {
                              setState(() {});
                              Get.offNamed('/');
                            } else {
                              dismissDialog(context: context);
                              Get.dialog(Dialog(
                                child: Text(" not good"),
                              ));
                            }
                            // if (ret == 1) {
                            //   dismissDialog(context: context);
                            //   Get.dialog(Dialog(
                            //     child: Text("good sound"),
                            //   ));
                            // } else {
                            //   dismissDialog(context: context);
                            //   Get.dialog(Dialog(
                            //     child: Text(" not good"),
                            //   ));
                            // }

                          }

                          // AwesomeDialog(context: context).dismiss();
                        }),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: SizedBox(width: 10),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: ButtonWidget(
                        text: "back".tr,
                        icon: Icons.backspace_outlined,
                        onClicked: () {
                          dismissDialog(context: context);
                        }),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  getAva() async {
    try {
      final value = await stockListAva;
      final value2 = value?.data.mainStock!.toList();
      value2?.forEach((e) {
        listAva.add(MainStock(
            barcode: e.barcode,
            createdAt: e.createdAt,
            cateId: e.cateId,
            code: e.code,
            cate: e.cate,
            qty: e.qty,
            unit: e.unit,
            cost: e.cost,
            lastBuy: e.lastBuy,
            salePrice: e.salePrice,
            product: e.product,
            id: e.id));
      });
      debugPrint("${listAva.length}");
    } catch (e) {
      debugPrint("sth cates");
    }
  }

  getNonAva() async {
    try {
      final value = await stockListNonAva;
      final value2 = value?.data.mainStock!.toList();
      value2?.forEach((e) {
        listNonAva.add(MainStock(
            barcode: e.barcode,
            createdAt: e.createdAt,
            cateId: e.cateId,
            code: e.code,
            cate: e.cate,
            qty: e.qty,
            unit: e.unit,
            cost: e.cost,
            lastBuy: e.lastBuy,
            salePrice: e.salePrice,
            product: e.product,
            id: e.id));
      });
      debugPrint("${listNonAva.length}");
    } catch (e) {
      debugPrint("sth cates");
    }
  }

  getNonPrice() async {
    try {
      final value = await stockListNoPrice;
      final value2 = value?.data.mainStock!.toList();
      value2?.forEach((e) {
        listNoPrice.add(MainStock(
            barcode: e.barcode,
            createdAt: e.createdAt,
            cateId: e.cateId,
            code: e.code,
            cate: e.cate,
            qty: e.qty,
            unit: e.unit,
            cost: e.cost,
            lastBuy: e.lastBuy,
            salePrice: e.salePrice,
            product: e.product,
            id: e.id));
      });
      debugPrint("${listNoPrice.length}");
    } catch (e) {
      debugPrint("sth cates");
    }
  }

  Widget getAvaList() {
    Size size = MediaQuery.of(context).size;

    // if (itr == 1) {
    //   // stockListAva = getInvRequestPost(
    //   //     fullUrl: "http://localhost:9098/myapp238/api/v1/stock/available");
    //   getAva();
    //   setState(() {});
    // }
    // itr++;
    List<DataColumn> getColumns(List<String> columns) => columns
        .map((String column) => DataColumn(
              // tooltip: "قائمة المخزون",
              label: Expanded(
                  child: Text(column,
                      textAlign:
                          TextAlign.center)), //Center(child: Text(column)),
              // onSort: onSort,
            ))
        .toList();
    List<String> columns = [
      // 'update'.tr,
      '#',
      'cate'.tr,
      'code'.tr,
      'name-product'.tr,
      'qty'.tr,
      'cost'.tr,
      'sale-price'.tr,
      'last-buy-price'.tr,
      'unit'.tr,
      // 'barcode'.tr,
    ];
    setState(() {});
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
    double r = size.width * 0.1;
    double r2 = size.width * 0.15;
    return Padding(
      padding: EdgeInsets.only(right: r, left: r2),
      child: Container(
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
              position: ScrollbarPosition.top,
              sliderDecoration: sliderDecoration,
              sliderActiveDecoration: sliderActiveDecoration,
              underDecoration: underDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              rows: listAva
                                  .map(
                                    (data) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(data.id.toString())),
                                        DataCell(Text(data.cate.toString())),
                                        DataCell(Text(data.code)),
                                        DataCell(Text(data.product)),
                                        DataCell(Text(data.qty.toString())),
                                        DataCell(Text(data.cost.toString())),
                                        DataCell(
                                            Text(data.salePrice.toString())),
                                        DataCell(Text(data.lastBuy.toString())),
                                        DataCell(Text(data.unit.toString())),
                                        // DataCell(Text(data.barcode)),
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
    );
  }

  Widget getAvaList1() {
    return Container(
      child: ListView.builder(
          itemCount: listAva.length,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          //  controller: h.AdjustableScrollController(80),
          shrinkWrap: true,
          // gridDelegate:
          //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(200)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: textColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 15),
                              blurRadius: 25,
                              color: Colors.black12),
                        ]),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(
                          '${'product'.tr} / ${listAva[index].product}',
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                      '${'qty'.tr} / ${listAva[index].qty}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2)),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                      '${'price'.tr} / ${listAva[index].salePrice}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget getAvaNonList() {
    // if (itrNon == 1) {
    //   // stockListNonAva = getInvRequestPost(
    //   //     fullUrl: "http://localhost:9098/myapp238/api/v1/stock/no-available");
    //   getNonAva();
    //   setState(() {});
    // }
    // itrNon++;
    List<DataColumn> getColumns(List<String> columns) => columns
        .map((String column) => DataColumn(
              label: Expanded(
                  child: Text(column,
                      textAlign:
                          TextAlign.center)), //Center(child: Text(column)),
              // onSort: onSort,
            ))
        .toList();
    List<String> columns = [
      // 'update'.tr,
      '#',
      'cate'.tr,
      'code'.tr,
      'name-product'.tr,
      'qty'.tr,
      'cost'.tr,
      'sale-price'.tr,
      'last-buy-price'.tr,
      'unit'.tr,
      // 'barcode'.tr,
    ];
    setState(() {});
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
    return Card(
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
                        padding: EdgeInsets.symmetric(horizontal: scrollWidth),
                        child: DataTable(
                          showBottomBorder: true,
                          sortAscending: isAscending,
                          sortColumnIndex: sortColumnIndex,
                          columns: getColumns(columns),
                          horizontalMargin: 10,
                          rows: listNonAva
                              .map(
                                (data) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(data.id.toString())),
                                    DataCell(Text(data.cate.toString())),
                                    DataCell(Text(data.code)),
                                    DataCell(Text(data.product)),
                                    DataCell(Text(data.qty.toString())),
                                    DataCell(Text(data.cost.toString())),
                                    DataCell(Text(data.salePrice.toString())),
                                    DataCell(Text(data.lastBuy.toString())),
                                    DataCell(Text(data.unit.toString())),
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
    );
  }

  Widget getNonPriceList() {
    // if (itrNonPrice == 1) {
    //   // stockListNoPrice = getInvRequestPost(
    //   //     fullUrl: "http://localhost:9098/myapp238/api/v1/stock/no-price");
    //   getNonPrice();
    //   setState(() {});
    // }
    // itrNonPrice++;
    List<DataColumn> getColumns(List<String> columns) => columns
        .map((String column) => DataColumn(
              label: Expanded(
                  child: Text(column,
                      textAlign:
                          TextAlign.center)), //Center(child: Text(column)),
              // onSort: onSort,
            ))
        .toList();
    List<String> columns = [
      'update'.tr,
      'ID',
      'cate'.tr,
      'code'.tr,
      'name-product'.tr,
      'qty'.tr,
      'cost'.tr,
      'sale-price'.tr,
      'last-buy-price'.tr,
      'unit'.tr,
    ];
    setState(() {});
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
    return Card(
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
                        padding: EdgeInsets.symmetric(horizontal: scrollWidth),
                        child: DataTable(
                          showBottomBorder: true,
                          sortAscending: isAscending,
                          sortColumnIndex: sortColumnIndex,
                          columns: getColumns(columns),
                          horizontalMargin: 10,
                          rows: listNoPrice
                              .map(
                                (data) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(IconButton(
                                      icon: Icon(Icons.update),
                                      onPressed: () {
                                        idController.text = data.id.toString();
                                        nameController.text =
                                            data.product.toString();
                                        newPriceController.text =
                                            data.salePrice.toString();
                                        newCostController.text =
                                            data.cost.toString();
                                        lastController.text =
                                            data.lastBuy.toString();

                                        Get.defaultDialog(
                                            title: "",
                                            content: Container(
                                              child: getAddNewItem(context),
                                            ));
                                      },
                                    )),
                                    DataCell(Text(data.id.toString())),
                                    DataCell(Text(data.cate.toString())),
                                    DataCell(Text(data.code)),
                                    DataCell(Text(data.product)),
                                    DataCell(Text(data.qty.toString())),
                                    DataCell(Text(data.cost.toString())),
                                    DataCell(Text(data.salePrice.toString())),
                                    DataCell(Text(data.lastBuy.toString())),
                                    DataCell(Text(data.unit.toString())),
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
    );
  }

  Widget getMovementList() {
    List<DataColumn> getColumns(List<String> columns) => columns
        .map((String column) => DataColumn(
              label: Expanded(
                  child: Text(column,
                      textAlign:
                          TextAlign.center)), //Center(child: Text(column)),
              // onSort: onSort,
            ))
        .toList();
    List<String> columns = [
      'cate'.tr,
      'code'.tr,
      'name-product'.tr,
      'qty_in'.tr,
      'qty_out'.tr,
      'price'.tr,
      'date'.tr,
      'unit'.tr,
      'barcode'.tr,
    ];
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
    return Card(
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
                        padding: EdgeInsets.symmetric(horizontal: scrollWidth),
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
                                    DataCell(Text(data.cost.toString())),
                                    DataCell(Text(data.salePrice.toString())),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(size.width.toString());
    return Scaffold(
      appBar: AppBar(
        //   backgroundColor: AColors.FireBrick,
        title: Text(
          "stock-products".tr,
          style: TextStyle(
            fontFamily: 'Arial',
            //   fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints(minWidth: 440),
        child: ListView(
          controller: h.AdjustableScrollController(80),
          children: [
            size.width >= 900
                ? Row(
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
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: IconButton(
                              icon: Icon(Icons.home, color: primaryColor),
                              onPressed: () {
                                Get.toNamed('/');
                                //  Get.to('/');
                              },
                            )),
                      ),
                      Spacer(),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: primaryColor),
                              onPressed: () {
                                //Get.toNamed('/');
                                //  Get.to('/');
                              },
                            )),
                      ),
                    ],
                  ),
            Divider(thickness: 1, color: notUpdtblColor),
            Column(
              children: [
                size.width >= 1100
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'available'.tr,
                                icon: Icons.event_available,
                                onClicked: () {
                                  selected = 0;
                                  setState(() {});
                                },
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'No-available'.tr,
                                icon: Icons.no_backpack_outlined,
                                onClicked: () {
                                  selected = 1;
                                  setState(() {});
                                },
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'price-list'.tr,
                                icon: Icons.price_change_outlined,
                                onClicked: () {
                                  selected = 2;
                                  setState(() {});
                                },
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'movement'.tr,
                                icon: Icons.move_down,
                                onClicked: () {
                                  selected = 3;
                                  setState(() {});
                                },
                              )),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              constraints: BoxConstraints(maxWidth: 500),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'available'.tr,
                                icon: Icons.event_available,
                                onClicked: () {
                                  selected = 0;
                                  setState(() {});
                                },
                              )),
                          Container(
                              constraints: BoxConstraints(maxWidth: 500),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'No-available'.tr,
                                icon: Icons.no_backpack_outlined,
                                onClicked: () {
                                  selected = 1;
                                  setState(() {});
                                },
                              )),
                          Container(
                              constraints: BoxConstraints(maxWidth: 500),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'price-list'.tr,
                                icon: Icons.price_change_outlined,
                                onClicked: () {
                                  selected = 2;
                                  setState(() {});
                                },
                              )),
                          Container(
                              constraints: BoxConstraints(maxWidth: 500),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              margin: const EdgeInsets.all(5),
                              child: ButtonWidget(
                                text: 'movement'.tr,
                                icon: Icons.move_down,
                                onClicked: () {
                                  selected = 3;
                                  setState(() {});
                                },
                              )),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Card(
                          //   child: Text("products appear here"),
                          // ),
                          selected == 0
                              ? size.width <= 900
                                  ? getAvaList1()
                                  : getAvaList()
                              : SizedBox(),
                          selected == 1 ? getAvaNonList() : SizedBox(),
                          selected == 2 ? getNonPriceList() : SizedBox(),
                          selected == 3 ? getMovementList() : SizedBox(),
                        ]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*
Center(
          child: Column(children: [
            Container(
              child: ListView(children: [
                Container(
                  child: ButtonWidget(
                    text: 'available'.tr,
                    icon: Icons.event_available,
                    onClicked: () {},
                  ),
                ),
                Container(
                  child: ButtonWidget(
                    text: 'available'.tr,
                    icon: Icons.event_available,
                    onClicked: () {},
                  ),
                ),
                Container(
                  child: ButtonWidget(
                    text: 'available'.tr,
                    icon: Icons.event_available,
                    onClicked: () {},
                  ),
                ),
              ]),
            ),
            // SizedBox(
            //   height: 10,
            //   child: Divider(thickness: 1, color: notUpdtblColor),
            // ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(children: [
                      Container(
                        child: ButtonWidget(
                          text: 'available'.tr,
                          icon: Icons.event_available,
                          onClicked: () {},
                        ),
                      ),
                      Container(
                        child: ButtonWidget(
                          text: 'available'.tr,
                          icon: Icons.event_available,
                          onClicked: () {},
                        ),
                      ),
                      Container(
                        child: ButtonWidget(
                          text: 'available'.tr,
                          icon: Icons.event_available,
                          onClicked: () {},
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(children: [
                      Container(
                        child: ButtonWidget(
                          text: 'available'.tr,
                          icon: Icons.event_available,
                          onClicked: () {},
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          ]),
        )
 */
