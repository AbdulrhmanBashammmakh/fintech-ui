import 'package:dropdown_search/dropdown_search.dart';
import 'package:fintech/views/Sales/sale-main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/BaseModel.dart';
import '../../models/Models.dart';
import '../../utils/AColors.dart';
import '../../widgets/button_main.dart';
import 'new-sale.dart';
import 'newSaleController.dart';

class NewSaleView extends StatelessWidget {
  NewSaleView({super.key});

  // final controller = Get.find<SaleController>();
  // Get.put(SaleController());
  // var controller = Get.find<SaleController>();
  final controller = Get.put(SaleController());
  GlobalKey<FormState> dataEntryFormState = GlobalKey<FormState>();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final controller =   Get.lazyPut(() => SaleController());
    var mdw = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        appBar: AppBar(
          //       backgroundColor: AColors.MediumSeaGreen,
          title: Text(
            "sales-add".tr,
            style: const TextStyle(
              fontFamily: 'Arial',
              //   fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [mainFunc(context, controller: controller)],
        ));
  }

  Widget mainFunc(context, {controller}) {
    return Column(
      children: [
        formInvoice(controller: controller),
        const SizedBox(
          height: 1,
          //  child: Divider(thickness: 1, color: notUpdtblColor),
        ),
        addButton(context, controller),
        GetBuilder<SaleController>(
            //   init: SaleController(),
            builder: (controller) {
          return detailsInvoice(context, controller: controller);
        }),
      ],
    );
  }

  Widget completeFunc(controller) {
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
                  controller: controller.amountController,
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

  Widget formInvoice({controller}) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
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
                  key: formState2,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: TextFormField(
                            enabled: false,
                            controller: controller.amountController,
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

  Widget addButton(context, controller) {
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
                        child: ButtonWidget(
                            text: "add".tr,
                            icon: Icons.verified,
                            onClicked: () {
                              Get.defaultDialog(
                                  title: "",
                                  content: Container(
                                    child: getFormInputDetails(context,
                                        controller: controller),
                                  ));
                              // showCustomDialog(
                              //     context: Widget.context,
                              //     btnCancelText: 'cancel'.tr,
                              //     btnOk: Container(),
                              //     btnCancel: Container(),
                              //     body: getFormInputDetails(),
                              //     dismissOnTouchOutside: false,
                              //     showCloseIcon: true,
                              //     width: mdw);
                            }))),
                Spacer(),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: ButtonWidget(
                          text: "add-invoice".tr,
                          icon: Icons.verified,
                          onClicked: () async {
                            // Get.dialog(Container(
                            //   width: MediaQuery.of(context).size.width * .8,
                            //   height: MediaQuery.of(context).size.height * .5,
                            //   child: Dialog(
                            //     child: setCustomerAndDiscount(context,
                            //         controller: controller),
                            //   ),
                            // )
                            // );
                            Get.defaultDialog(
                                title: '',
                                content: Container(
                                  width: MediaQuery.of(context).size.width * .8,
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  child: setCustomerAndDiscount(context,
                                      controller: controller),
                                ));
                            // show_Dialog(
                            //   context: context,
                            //   cancelPress: () {
                            //     dismissDialog();
                            //   },
                            //   btnOkText: "ok".tr,
                            //   btnCancelText: 'cancel'.tr,
                            //   btnOk: confirmButton(),
                            //   dialogType: "Q",
                            //   title: "هل تريد الاستمرار",
                            //   desc: "هل تريد اضافة الفاتورة",
                            // );
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

  Widget detailsInvoice(context, {controller}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        //  width: mdw,
        child: Center(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: controller.verticalScrollController,
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        controller: controller.horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: controller.scrollWidth),
                            child: GetBuilder<SaleController>(
                                //  init: SaleController(),
                                builder: (controller) {
                              return DataTable(
                                showBottomBorder: true,
                                sortAscending: controller.isAscending,
                                sortColumnIndex: controller.sortColumnIndex,
                                columns:
                                    controller.getColumns(controller.columns),
                                horizontalMargin: 10,
                                rows: controller.dataRequest
                                    .map(
                                      (data) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(ElevatedButton(
                                              onPressed: () {
                                                controller.dataRequest
                                                    .remove(data);
                                                sumInvoice(
                                                    controller: controller);
                                                controller.getDataRequest();
                                                controller.getListShowRemoved(
                                                    data.code);
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
                                          DataCell(
                                              Text(data.amount.toString())),
                                          DataCell(Text(data.unit)),
                                          DataCell(Text(data.code)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              );
                            })),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton confirmButton(context, {controller}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        Get.defaultDialog(
            content: Text('issue-invoice'.tr),
            onConfirm: () async {
              var inv = InvoiceSale(
                  total: double.parse(controller.amountController.text),
                  discount: double.parse(controller.discountController.text),
                  customer: controller.customerController.text);
              List<ItemSale> itm = [];
              for (var e in controller.dataRequest) {
                itm.add(ItemSale(
                    qty: e.qty, code: e.code, price: e.price, amt: e.amount));
              }
              dismissDialog(context: context);
              int x = await sendPostRequestSales(myList: itm, myObject: inv);
              debugPrint("$x");
              if (x == 1) {
                controller.amountController.text = '0';
                controller.dataRequest.clear();
                controller.finish();
                // controller.complete = true;

                //  Get.toNamed("/sale");
                Get.offNamed("/sale");
                //  controller.close();
              } else {
                // show_Dialog(desc: "no".tr, dialogType: 'E', context: context);
              }
            },
            onCancel: () {},
            title: "confirm-oprt".tr,
            // confirm: Text('ok'.tr),
            // cancel: Text('cancel'.tr)
            confirmTextColor: Colors.white);
      },
    );
  }

  setCustomerAndDiscount(context, {controller}) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .5,
      child: Form(
          key: formState,
          child: GetBuilder<SaleController>(
            init: SaleController(),
            builder: (controller) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    child: Text(
                      'اخر خطوة'.tr,
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
                            controller: controller.amountController,
                            decoration: InputDecoration(
                              label: Text("total".tr),
                              counterText: "",
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: TextFormField(
                            controller: controller.discountController,
                            decoration: InputDecoration(
                              label: Text("discount".tr),
                              // counterText: "0",
                            ),
                            validator: (text) {
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
                            controller: controller.customerController,
                            decoration: InputDecoration(
                              label: Text("customer".tr),
                              counterText: "",
                            ),
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
                          child: confirmButton(context, controller: controller),
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
              );
            },
          )),
    );
  }

  getFormInputDetails(context, {controller}) {
    reset(controller: controller);
    return Form(
        key: dataEntryFormState,
        child: GetBuilder<SaleController>(
          init: SaleController(),
          builder: (controller) {
            return Column(
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
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          child: getCateContainer(controller: controller)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          child: getMainStockContainer(controller: controller)),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          enabled: false,
                          readOnly: true,
                          controller: controller.qtyAController,
                          decoration: InputDecoration(
                            label: Text("qty".tr),
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //    color: Colors.grey.shade500,
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: controller.priceAController,
                          decoration: InputDecoration(
                            label: Text("cost".tr),
                            counterText: "",
                          ),
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
                        child: TextFormField(
                          controller: controller.codeController,
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
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: controller.productController,
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
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: controller.qtyController,
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
                          controller: controller.priceController,
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
                                double pr = double.parse(
                                    controller.priceController.text);
                                int qt =
                                    int.parse(controller.qtyController.text);
                                double amt = pr * qt;

                                var det = detSale(
                                    amount: amt,
                                    code: controller.codeController.text,
                                    name: controller.productController.text,
                                    cate: controller.cate.id,
                                    price: pr,
                                    qty: qt,
                                    unit: controller.unitController.text,
                                    cateName: controller.cate.name,
                                    unitName: controller.baseModel.name);

                                if (controller.isAccepted(
                                    controller.codeController.text)) {
                                  fillTable(det, controller: controller);
                                  controller.changeQty(det.code, det.qty);
                                  dismissDialog(context: context);
                                  reset(controller: controller);
                                  controller.getDataRequest();
                                } else {
                                  reset(controller: controller);
                                  dismissDialog(context: context);
                                  Get.dialog(Dialog(
                                    child: Text("in the table"),
                                  ));
                                }
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
            );
          },
        ));
  }

  fillTable(detSale det, {controller}) {
    controller.dataRequest.add(det);

    sumInvoice(controller: controller);
    // setState(() {});
  }

  sumInvoice({controller}) {
    double x = 0;
    for (var e in controller.dataRequest) {
      x += e.amount;
    }
    controller.amountController.text = x.toString();
  }

  reset({controller}) {
    controller.priceController.text = '';
    controller.qtyController.text = '';
    controller.priceAController.text = '';
    controller.qtyAController.text = '';
    controller.codeController.text = '';
    controller.productController.text = '';
    controller.cateController.text = '0';
    controller.unitController.text = '';
    controller.baseModel = BaseModel(id: 0, name: '');
    controller.cate = BaseModel(id: 0, name: '');
    controller.mainStock = MainStock(
        barcode: '',
        createdAt: '',
        cateId: 0,
        code: '',
        cate: '',
        qty: 0,
        unit: '',
        cost: 0,
        lastBuy: 0,
        salePrice: 0,
        product: '',
        id: 0);

    // controller.getStock('0');
  }

  Widget endInvoice({controller}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
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

  Widget getCateContainer({controller}) {
    return FutureBuilder<ResponseObject>(
        future: controller.catesDataFuture,
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
                showSelectedItems: controller.baseModel.id == 0 ? false : true,
                menuProps: const MenuProps(
                    elevation: 10, constraints: BoxConstraints(maxHeight: 150)),
              ),
              items: uList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "cate".tr,
              ),
              dropdownBuilder: CateListItem,
              onChanged: (item) {
                controller.cateController.text = item!.id.toString();
                controller.refreshItems();
                //  print(unitController.text);
                controller.cate = item;
                controller.getStock(controller.cateController.text);
                //   setState(() {});
              },
              selectedItem: controller.cate,
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

  Widget getMainStockContainer({controller}) {
    return FutureBuilder<ResponseObject>(
        future: controller.avaDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.data.mainStock;
            List<MainStock> uList = list!.map((e) {
              MainStock model = MainStock(
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
                  id: e.id);
              return model;
            }).toList();
            controller.setMainList(uList.toList());

            if (list.isEmpty) {
              return Container();
            }
            return DropdownSearch<MainStock>(
              popupProps: PopupProps.dialog(
                itemBuilder: mainStockListItemBuilder,
                showSelectedItems: controller.mainStock.id == 0 ? false : true,
                // menuProps: const MenuProps(
                //     elevation: 10, constraints: BoxConstraints(maxHeight: 150)),
              ),
              items: controller.mainList2,
              dropdownSearchDecoration: InputDecoration(
                labelText: "product".tr,
              ),
              dropdownBuilder: mainStockListItem,
              onChanged: (item) {
                controller.mainStock = item!;
                controller.setItems(controller.mainStock);
              },
              selectedItem: controller.mainStock,
              enabled: true,
              compareFn: (i, s) => i.isEqual(s),
              validator: (text) {
                if (text!.product.isEmpty) return "required".tr;
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

Widget mainStockListItem(BuildContext context, MainStock? item) {
  return Container(
    child: (item?.id == 0 || item == null)
        ? Text('select-a-item'.tr)
        : ListTile(title: Text(item.product)),
  );
}

Widget CateListItem(BuildContext context, BaseModel? item) {
  return Container(
    child: (item?.id == 0 || item == null)
        ? Text('select-a-cate'.tr)
        : ListTile(title: Text(item.name)),
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

Widget mainStockListItemBuilder(
    BuildContext context, MainStock? item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(title: Text("${item?.code} - ${item!.product}")),
  );
}

bool isNumeric(String str) {
  if (str.isEmpty) {
    return false;
  }
  return double.tryParse(str) != null;
}
