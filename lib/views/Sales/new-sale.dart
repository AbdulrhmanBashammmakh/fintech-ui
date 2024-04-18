import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fintech/views/Sales/sale-main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/BaseModel.dart';
import '../../models/Models.dart';
import '../../utils/AColors.dart';
import '../../utils/Constants.dart';
import '../../widgets/button_main.dart';

class NewSale extends StatefulWidget {
  const NewSale({super.key});

  @override
  State<NewSale> createState() => _NewSaleState();
}

class _NewSaleState extends State<NewSale> {
  bool complete = false;
  BaseModel baseModel = BaseModel(id: 0, name: '');
  BaseModel cate = BaseModel(id: 0, name: '');
  BaseModel vendor = BaseModel(id: 0, name: '');
  GlobalKey<FormState> dataEntryFormState = GlobalKey<FormState>();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController cateController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController dateInvoiceController = TextEditingController();
  TextEditingController recNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
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
  List<detSale> DataRequest = <detSale>[];
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
  Future<ResponseObject>? _unitsDataFuture;
  Future<ResponseObject>? _vendorsDataFuture;
  Future<ResponseObject>? _catesDataFuture;
  String urlUnit = ApiEndPoint.URL + ApiEndPoint.UnitMainAll;
  String urlVendor = ApiEndPoint.URL + ApiEndPoint.VendorMainAll;
  String urlCate = ApiEndPoint.URL + ApiEndPoint.CateMainAll;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      amountController.text = 0.0.toString();
      _unitsDataFuture = getAllMainRequest(fullUrl: urlUnit);
      _vendorsDataFuture = getAllMainRequest(fullUrl: urlVendor);
      _catesDataFuture = getAllMainRequest(fullUrl: urlCate);
      // getaAll();
      setState(() {});
    });

    super.initState();
  }

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
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        appBar: AppBar(
          //       backgroundColor: AColors.MediumSeaGreen,
          title: Text(
            "pch-add".tr,
            style: const TextStyle(
              fontFamily: 'Arial',
              //   fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [complete ? completeFunc() : mainFunc()],
        ));
  }

  Widget mainFunc() {
    return Column(
      children: [
        formInvoice(),
        const SizedBox(
          height: 1,
          //  child: Divider(thickness: 1, color: notUpdtblColor),
        ),
        addButton(),
        detailsInvoice(),
      ],
    );
  }

  Widget completeFunc() {
    return Center(
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text("قيمة الفاتورة"),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
              ),
              const SizedBox(
                height: 10,
              ),
              //    Spacer(),
              Container(
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
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: ButtonWidget(
                    text: "exit".tr,
                    icon: Icons.exit_to_app_sharp,
                    onClicked: () {
                      Get.off(() => SaleMain());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formInvoice() {
    var mdw = MediaQuery.of(context).size.width * 0.5;

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      width: mdw,
      child: Column(
        children: [
          Card(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Container(child: Text("راس الفاتورة")),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formState,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: getVendorContainer()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
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
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addButton() {
    var mdw = MediaQuery.of(context).size.width * 0.8;

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        width: mdw / 3,
                        child: ButtonWidget(
                            text: "add".tr,
                            icon: Icons.verified,
                            onClicked: () {
                              showCustomDialog(
                                  context: context,
                                  btnCancelText: 'cancel'.tr,
                                  btnOk: Container(),
                                  btnCancel: Container(),
                                  body: getFormInputDetails(),
                                  dismissOnTouchOutside: false,
                                  showCloseIcon: true,
                                  width: mdw);
                            }))),
                Spacer(),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      width: mdw / 3,
                      child: ButtonWidget(
                          text: "add-invoice".tr,
                          icon: Icons.verified,
                          onClicked: () async {
                            show_Dialog(
                              context: context,
                              cancelPress: () {
                                dismissDialog();
                              },
                              btnOkText: "ok".tr,
                              btnCancelText: 'cancel'.tr,
                              btnOk: confirmButton(),
                              dialogType: "Q",
                              title: "هل تريد الاستمرار",
                              desc: "هل تريد اضافة الفاتورة",
                            );
                          })),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsInvoice() {
    var mdw = MediaQuery.of(context).size.width * 0.9;

    return Center(
      child: Container(
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: scrollWidth),
                              child: DataTable(
                                showBottomBorder: true,
                                sortAscending: isAscending,
                                sortColumnIndex: sortColumnIndex,
                                columns: getColumns(columns),
                                horizontalMargin: 10,
                                rows: DataRequest.map(
                                  (data) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(ElevatedButton(
                                          onPressed: () {
                                            DataRequest.remove(data);
                                            sumInvoice();
                                            setState(() {});
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    secondaryColor),
                                          ),
                                          child: Text('delete'.tr))),
                                      DataCell(Text(data.cateName)),
                                      DataCell(Text(data.code)),
                                      DataCell(Text(data.name)),
                                      DataCell(Text(data.qty.toString())),
                                      DataCell(Text(data.price.toString())),
                                      DataCell(Text(data.amount.toString())),
                                      DataCell(Text(data.unitName)),
                                      DataCell(Text(data.code)),
                                    ],
                                  ),
                                ).toList(),
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
    );
  }

  ElevatedButton confirmButton() {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        var inv = Invoice(
            total: double.parse(amountController.text),
            discount: 0.0,
            flag: 0,
            vendor: vendor.id);
        List<Item> itm = [];
        for (var e in DataRequest) {
          itm.add(
              Item(e.price, e.amount, e.name, e.code, e.cate, e.qty, e.unit));
        }
        dismissDialog(context: context);
        int x = await sendPostRequest(myList: itm, myObject: inv);
        debugPrint("$x");
        if (x == 1) {
          complete = true;
          setState(() {});
        } else {
          show_Dialog(desc: "no".tr, dialogType: 'E', context: context);
        }
      },
    );
  }

  getFormInputDetails() {
    reset();
    return StatefulBuilder(builder: (context, setState) {
      bool isLoading = false;
      return Form(
        key: dataEntryFormState,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: Text(
                'add-product'.tr,
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
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: codeController,
                      decoration: InputDecoration(
                        label: Text("code".tr),
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
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: productController,
                      decoration: InputDecoration(
                        label: Text("name-product".tr),
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
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: getCateContainer()),
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: getUnitContainer()),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: qtyController,
                      decoration: InputDecoration(
                        label: Text("qty".tr),
                        counterText: "",
                      ),
                      validator: (text) {
                        if (text == '') return "required".tr;
                        if (!isNumeric(text!)) return "numbers-only".tr;
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        label: Text("price".tr),
                        counterText: "",
                      ),
                      validator: (text) {
                        if (text == '') return "required".tr;
                        if (!isNumeric(text!)) return "numbers-only".tr;
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
                        text: "add".tr,
                        icon: Icons.add,
                        onClicked: () {
                          if (dataEntryFormState.currentState!.validate()) {
                            double pr = double.parse(priceController.text);
                            int qt = int.parse(qtyController.text);
                            double amt = pr * qt;

                            var det = detSale(
                                amount: amt,
                                code: codeController.text,
                                name: productController.text,
                                cate: cate.id,
                                price: pr,
                                qty: qt,
                                unit: baseModel.id,
                                cateName: cate.name,
                                unitName: baseModel.name);
                            fillTable(det);

                            dismissDialog(context: context);
                            reset();
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
              ],
            ),
          ],
        ),
      );
    });
  }

  fillTable(detSale det) {
    DataRequest.add(det);
    sumInvoice();
    setState(() {});
  }

  sumInvoice() {
    double x = 0;
    for (var e in DataRequest) {
      x += e.amount;
    }
    amountController.text = x.toString();
  }

  reset() {
    priceController.text = '';
    qtyController.text = '';
    codeController.text = '';
    productController.text = '';
    cateController.text = '';
    unitController.text = '';
    baseModel = BaseModel(id: 0, name: '');
    cate = BaseModel(id: 0, name: '');
  }

  Widget endInvoice() {
    var mdw = MediaQuery.of(context).size.width * 0.3;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        width: mdw,
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: ButtonWidget(
                text: "add".tr, icon: Icons.verified, onClicked: () {}),
          ),
        ),
      ),
    );
  }

  Widget getUnitContainer() {
    return FutureBuilder<ResponseObject>(
        future: _unitsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.data.rep;
            List<BaseModel> uList = list!.map((e) {
              int id = e.id;
              String name = e.name;
              BaseModel model = BaseModel(id: id, name: name);
              return model;
            }).toList();
            if (list.isEmpty) {
              return Container();
            }
            return DropdownSearch<BaseModel>(
              popupProps: PopupProps.menu(
                itemBuilder: UnitListItemBuilder,
                showSelectedItems: baseModel.id == 0 ? false : true,
                menuProps: const MenuProps(
                    elevation: 10, constraints: BoxConstraints(maxHeight: 150)),
              ),
              items: uList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "unit".tr,
              ),
              dropdownBuilder: UnitListItem,
              onChanged: (item) {
                unitController.text = item!.id.toString();
                baseModel = item;
                setState(() {});
              },
              selectedItem: baseModel,
              enabled: true,
              compareFn: (i, s) => i.isEqual(s),
              validator: (text) {
                if (text!.name.isEmpty) return "required".tr;
                return null;
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          }

          return Container();
        });
  }

  Widget getCateContainer() {
    return FutureBuilder<ResponseObject>(
        future: _catesDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.data.rep;
            List<BaseModel> uList = list!.map((e) {
              int id = e.id;
              String name = e.name;
              BaseModel model = BaseModel(id: id, name: name);
              return model;
            }).toList();
            if (list.isEmpty) {
              return Container();
            }
            return DropdownSearch<BaseModel>(
              popupProps: PopupProps.menu(
                itemBuilder: CateListItemBuilder,
                showSelectedItems: baseModel.id == 0 ? false : true,
                menuProps: const MenuProps(
                    elevation: 10, constraints: BoxConstraints(maxHeight: 150)),
              ),
              items: uList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "cate".tr,
              ),
              dropdownBuilder: CateListItem,
              onChanged: (item) {
                cateController.text = item!.id.toString();
                //  print(unitController.text);
                cate = item;
                setState(() {});
              },
              selectedItem: cate,
              enabled: true,
              compareFn: (i, s) => i.isEqual(s),
              validator: (text) {
                if (text!.name.isEmpty) return "required".tr;
                return null;
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          }

          return Container();
        });
  }

  Widget getVendorContainer() {
    return FutureBuilder<ResponseObject>(
        future: _vendorsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.data.rep;
            List<BaseModel> uList = list!.map((e) {
              int id = e.id;
              String name = e.name;
              BaseModel model = BaseModel(id: id, name: name);
              return model;
            }).toList();
            if (list.isEmpty) {
              return Container();
            }
            return DropdownSearch<BaseModel>(
              popupProps: PopupProps.menu(
                itemBuilder: VendorListItemBuilder,
                showSelectedItems: baseModel.id == 0 ? false : true,
                menuProps: const MenuProps(
                    elevation: 10, constraints: BoxConstraints(maxHeight: 150)),
              ),
              items: uList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "vendor".tr,
              ),
              dropdownBuilder: vendorListItem,
              onChanged: (item) {
                vendorController.text = item!.id.toString();
                //  print(unitController.text);
                vendor = item;
                setState(() {});
              },
              selectedItem: vendor,
              enabled: true,
              compareFn: (i, s) => i.isEqual(s),
              validator: (text) {
                if (text!.name.isEmpty) return "required".tr;
                return null;
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          }

          return Container();
        });
  }
}

Widget vendorListItem(BuildContext context, BaseModel? item) {
  return Container(
    child: (item?.id == 0 || item == null)
        ? Text('select-a-vendor'.tr)
        : ListTile(title: Text(item.name)),
  );
}

Widget CateListItem(BuildContext context, BaseModel? item) {
  return Container(
    child: (item?.id == 0 || item == null)
        ? Text('select-a-cate'.tr)
        : ListTile(title: Text(item.name)),
  );
}

Widget UnitListItem(BuildContext context, BaseModel? item) {
  return Container(
    child: (item?.id == 0 || item == null)
        ? Text('select-a-unit'.tr)
        : ListTile(title: Text(item.name)),
  );
}

Widget UnitListItemBuilder(
    BuildContext context, BaseModel? item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(title: Text("${item?.id} - ${item!.name}")),
  );
}

Widget CateListItemBuilder(
    BuildContext context, BaseModel? item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(title: Text("${item?.id} - ${item!.name}")),
  );
}

Widget VendorListItemBuilder(
    BuildContext context, BaseModel? item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(title: Text("${item?.id} - ${item!.name}")),
  );
}

bool isNumeric(String str) {
  if (str.isEmpty) {
    return false;
  }
  return double.tryParse(str) != null;
}

class detSale {
  final String code;
  final String name;
  final int cate;
  final int unit;
  final String cateName;
  final String unitName;
  final double price;
  final double amount;
  final int qty;

  detSale({
    required this.amount,
    required this.code,
    required this.name,
    required this.cate,
    required this.unit,
    required this.cateName,
    required this.unitName,
    required this.price,
    required this.qty,
  });
}
