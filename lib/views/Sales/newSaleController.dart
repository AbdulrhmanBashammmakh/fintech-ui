// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../models/BaseModel.dart';
import '../../models/Models.dart';
import '../../models/list-item-model.dart';
import '../../utils/AColors.dart';
import '../../utils/Constants.dart';
import 'new-sale.dart';

class SaleController extends GetxController {
  bool complete = false;
  bool showResult = false;
  ListItemModel userListItemModel = ListItemModel();
  BaseModel baseModel = BaseModel(id: 0, name: '');
  BaseModel cate = BaseModel(id: 0, name: '');
  BaseModel vendor = BaseModel(id: 0, name: '');
  MainStock mainStock = MainStock(
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
  MainStock mainStockSelected = MainStock(
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

  // GlobalKey<FormState> dataEntryFormState = GlobalKey<FormState>();
  // GlobalKey<FormState> formState = GlobalKey<FormState>();
  // GlobalKey<FormState> formState2 = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceAController = TextEditingController();
  TextEditingController qtyAController = TextEditingController();
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
  List<detSale> dataRequest = <detSale>[];
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();
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
  Future<ResponseObject>? unitsDataFuture;
  Future<ResponseObject>? vendorsDataFuture;
  Future<ResponseObject>? avaDataFuture;
  Future<ResponseObject>? catesDataFuture;
  String urlUnit = ApiEndPoint.URL + ApiEndPoint.UnitMainAll;
  String urlVendor = ApiEndPoint.URL + ApiEndPoint.VendorMainAll;
  String urlCate = ApiEndPoint.URL + ApiEndPoint.CateMainAll;
  List<MainStock>? mainList;
  List<MainStock> mainList2 = [];
  List<MainStock> mainListRemoved = [];
  int a = 1;
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
  void onInit() {
    amountController.text = 0.0.toString();
    discountController.text = 0.0.toString();
    avaDataFuture = getInvRequestPost(
        fullUrl: "http://localhost:9098/myapp238/api/v1/stock/available");
    catesDataFuture = getAllMainRequest(fullUrl: urlCate);
    super.onInit();
  }

  @override
  void onClose() {
    dataRequest.clear();
    mainList!.clear();
    mainList2.clear();
    mainListRemoved.clear();
    amountController.dispose();
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    discountController.dispose();
    productController.dispose();
    unitController.dispose();
    customerController.dispose();
    codeController.dispose();
    cateController.dispose();
    qtyAController.dispose();
    qtyController.dispose();
    priceController.dispose();
    priceAController.dispose();
    vendorController.dispose();
    dateInvoiceController.dispose();
    recNameController.dispose();
    fromDateController.dispose();
    toDateController.dispose();

    super.onClose();
  }

  finish() {
    discountController.text = 0.0.toString();
    customerController.text = '';
    avaDataFuture = getInvRequestPost(
        fullUrl: "http://localhost:9098/myapp238/api/v1/stock/available");
    a = 1;
    refreshItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  refreshItems() {
    mainList;
    update();
  }

  setMainList(list) {
    if (a == 1) {
      mainList = list;
    }
    a++;
    // update();
  }

  getStock(String x) {
    mainList2.clear();
    mainList2 = mainList!.where((e) => e.cateId.toString() == x).toList();
    debugPrint('${mainList2.length} mainList2');
    update();
  }

  setItemInText(String x) {
    mainStockSelected = mainList!.where((e) => e.code == x).first;
    priceController.text = mainStockSelected.salePrice.toString();
    productController.text = mainStockSelected.product.toString();
    priceAController.text = mainStockSelected.cost.toString();
    qtyAController.text = mainStockSelected.qty.toString();
    cateController.text = mainStockSelected.cate.toString();
    unitController.text = mainStockSelected.unit.toString();
    codeController.text = mainStockSelected.code.toString();
    update();
  }

  changeQty(String x, int q) {
    MainStock change = mainList!.firstWhere((e) => e.code.toString() == x);
    mainListRemoved.add(change);
    mainList!.removeWhere((e) => e.code.toString() == x);
    mainList2.clear();
    update();
  }

  setItems(MainStock x) {
    productController.text = x.product;
    codeController.text = x.code;
    priceAController.text = x.cost.toString();
    priceController.text = x.salePrice.toString();
    qtyAController.text = x.qty.toString();
    unitController.text = x.unit;
    update();
  }

  getDataRequest() {
    dataRequest;
    update();
  }

  getListShowRemoved(String x) {
    MainStock change =
        mainListRemoved.firstWhere((e) => e.code.toString() == x);
    mainList!.add(change);
    mainListRemoved.removeWhere((e) => e.code.toString() == x);
    update();
  }

  bool isAccepted(String x) {
    return dataRequest.where((e) => e.code == x).isEmpty ? true : false;
  }

  getShow(String x) {
    showResult = isAccepted(x);
    update();
  }
}
