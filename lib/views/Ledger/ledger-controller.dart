import 'package:fintech/endPoint/send-req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LedgerController extends GetxController {
  Future<ResponseObject>? vendorDataFuture;
  List<RepRow> list = [];
  TextEditingController disController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController dateInvoiceController = TextEditingController();
  TextEditingController idController = TextEditingController();
  @override
  void onInit() {
    vendorDataFuture = getInvRequestPost(
        fullUrl: "http://localhost:9098/myapp238/api/v1/main/trans/all");
    getaAll();

    super.onInit();
  }

  getaAll() async {
    try {
      final value = await vendorDataFuture;
      final value2 = value?.data.rep!.toList();
      value2?.forEach((e) {
        list.add(RepRow(
            name: e.name,
            id: e.id,
            opts: e.opts,
            active: e.active,
            type: e.type,
            createdAt: e.createdAt,
            address: e.address,
            phone: e.phone,
            from: e.from,
            to: e.to,
            amount: e.amount));
      });
      update();
      debugPrint("${list.length}");
    } catch (e) {
      debugPrint("sth RepRow");
    }
  }
}
