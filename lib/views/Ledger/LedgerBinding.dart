import 'package:get/get.dart';

import 'ledger-controller.dart';

class LedgerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LedgerController());
    Get.create(() => LedgerController());
  }
}
