import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Models.dart';
import '../../utils/AColors.dart';
import '../../widgets/button_main.dart';

class StockMain extends StatefulWidget {
  const StockMain({super.key});

  @override
  State<StockMain> createState() => _StockMainState();
}

class _StockMainState extends State<StockMain> {
  List<TempDet> list = [];
  int selected = 0;

  Widget getAvaList() {
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
      'delete'.tr,
      'cate'.tr,
      'code'.tr,
      'name-product'.tr,
      'qty'.tr,
      'price'.tr,
      'amount'.tr,
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
    );
  }

  Widget getAvaNonList() {
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
    );
  }

  Widget getNonPriceList() {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //   backgroundColor: AColors.FireBrick,
          title: const Text(
            "المنتجات والمخزون",
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
            Row(
              children: [
                Expanded(
                  child: Column(
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
                  ),
                  flex: 2,
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Card(
                          //   child: Text("products appear here"),
                          // ),
                          selected == 0 ? getAvaList() : SizedBox(),
                          selected == 1 ? getAvaNonList() : SizedBox(),
                          selected == 2 ? getNonPriceList() : SizedBox(),
                          selected == 3 ? getMovementList() : SizedBox(),
                        ]))
              ],
            )
          ],
        ));
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
