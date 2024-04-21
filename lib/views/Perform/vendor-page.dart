import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../endPoint/send-req.dart';
import '../../utils/AColors.dart';
import '../../utils/AjustScroll.dart' as h;
import '../../widgets/button_main.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({super.key});

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  Future<ResponseObject>? vendorDataFuture;
  List<RepRow> list = [];
  List<String> columns = [
    // 'update'.tr,
    // 'delete'.tr,
    'id'.tr,
    'phone'.tr,
    'name'.tr,
    'address'.tr,
    'active'.tr,
    'createdAt'.tr,
  ];

  TextEditingController disController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
      vendorDataFuture = getInvRequestPost(
          fullUrl: "http://localhost:9098/myapp238/api/v1/main/vendor/all");

      setState(() {});
    });

    super.initState();
  }

  ElevatedButton confirmButton({createdAt, id, name, phone, add}) {
    return ElevatedButton(
      child: Text("yes".tr),
      onPressed: () async {
        debugPrint("${id}");
        // var det = await getDetSaleRequest(parm: id);
        idController.text = id.toString();
        dateInvoiceController.text = createdAt;
        addressController.text = add.toString();
        vendorController.text = name;
        phoneController.text = phone;
        dismissDialog(context: context);
        // list = det.data.rep!;
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
      child: Center(
        child: Container(
            height: 80,
            width: 250,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: ButtonWidget(
              text: 'add-new'.tr,
              icon: Icons.account_circle_outlined,
              onClicked: () {
                // Get.toNamed('/perform');
              },
            )),
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
                child: Text("details".tr),
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
                      controller: vendorController,
                      decoration: InputDecoration(
                        label: Text("name".tr),
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        label: Text("phone".tr),
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
                      controller: addressController,
                      decoration: InputDecoration(
                        label: Text("address".tr),
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
          title: Text(
            "vendors".tr,
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
                        onClicked: () {
                          Get.toNamed('/perform');
                        },
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
                    future: vendorDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final units = (snapshot.data!.data.rep ?? []).toList();
                        debugPrint("reply ${units.length}");
                        return units.isEmpty
                            ? Card(
                                child: Center(
                                    child:
                                        Container(child: Text("Not things"))),
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
                                      debugPrint("reply ${unit.id}");
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
                                                add: unit.address,
                                                name: unit.name,
                                                phone: unit.phone,
                                                id: unit.id,
                                                createdAt: unit.createdAt),
                                            dialogType: "Q",
                                            title:
                                                "  هل تريد اظهار بيانات الفاتورة",
                                            desc: " رقم${unit.id} ",
                                          );

                                          // setState(() {});
                                        },
                                        child: Card(
                                            child: ListTile(
                                          title: Text(unit.name),
                                          subtitle: Text(unit.createdAt),
                                          trailing: Text(unit.id.toString()),
                                          leading: Icon(Icons.man),
                                        )),
                                      );
                                    },
                                  ),
                                ),
                              );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("حدث خطأ"));
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
                                height: 400,
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
