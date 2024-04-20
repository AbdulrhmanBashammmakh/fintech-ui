import 'package:dio/dio.dart';
import 'package:fintech/models/Models.dart';

const String urlApi = "http://localhost:9098/myapp238/api/v1/temp/insert";

Dio dio = Dio();

Future<int> sendPostRequest({myObject, myList}) async {
  final invoiceData = {
    'temp': myObject.toJson(),
    'items': myList.map((item) => item.toJson()).toList(),
  };

  try {
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/temp/insert",
      data: invoiceData,
    );

    if (response.statusCode == 200) {
      return 1;
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

Future<int> sendPostRequestSales({myObject, myList}) async {
  final invoiceData = {
    'sale': myObject.toJson(),
    'items': myList.map((item) => item.toJson()).toList(),
  };

  try {
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/sale/insert",
      data: invoiceData,
    );

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

Future<int> sendPostRequestVer({temp, discount}) async {
  final invoiceData = {
    'temp_id': temp,
    'discount': discount,
  };

  try {
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/pch/insert",
      data: invoiceData,
    );

    if (response.statusCode == 200) {
      return 1;
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

Future<ResponseObject> getAllMainRequest({fullUrl}) async {
  try {
    final response = await dio.post(
      fullUrl,
      //  data: invoiceData,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

Future<ResponseObject> getInvRequest({fullUrl}) async {
  try {
    final response = await dio.get(
      fullUrl,
      //  data: invoiceData,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

Future<ResponseObject> getInvRequestPost({fullUrl}) async {
  try {
    final response = await dio.post(
      fullUrl,
      //  data: invoiceData,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

Future<ResponseObject> getInvRequestVer({fullUrl}) async {
  try {
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/pch/all",
      //  data: invoiceData,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

Future<ResponseObject> getDetTempRequest({required int parm}) async {
  try {
    final data = {
      'parm': parm,
    };
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/temp/details",
      data: data,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

Future<ResponseObject> getDetPchRequest({required int parm}) async {
  try {
    final data = {
      'parm': parm,
    };
    final response = await dio.post(
      "http://localhost:9098/myapp238/api/v1/pch/details",
      data: data,
    );

    if (response.statusCode == 200) {
      final reply = response.data;
      //    debugPrint("reply $reply");
      //jsonDecode(reply)
      return ResponseObject.fromJson(reply);
      // show_Dialog(desc: "done".tr, dialogType: 'S', context: context);
    } else {
      return ResponseObject.fromJson(null);
    }
  } catch (e) {
    return ResponseObject.fromJson(null);
  }
}

class Result {
  final int errorNo;
  final String errorNa;

  // final bool status;
  Result({
    required this.errorNo,
    required this.errorNa,
    // required this.status
  });

  factory Result.fromJson(Map<String, dynamic>? json) {
    int errorNo = int.parse(json?['errNo']?.toString() ?? '0');
    String errorNa = json?['errMessage'] ?? '';
    // debugPrint(errorNa);
    // bool status = json?['status'];
    return Result(
      errorNo: errorNo, errorNa: errorNa,
      // status: status
    );
  }
}

class RepRow {
  final String name;
  final int id;
  bool isSelected = false;

  RepRow({
    required this.name,
    required this.id,
  });

  factory RepRow.fromJson(Map<String, dynamic>? json) {
    String name = json?['name'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');

    return RepRow(name: name, id: id);
  }
}

class Data {
  final List<RepRow>? rep;
  final List<InvoiceModel>? invs;
  final List<TempDet>? dets;
  final List<HeadModel>? heads;
  final List<PchDet>? pchDets;
  final List<MainStock>? mainStock;

  Data({
    required this.rep,
    required this.invs,
    required this.dets,
    required this.heads,
    required this.pchDets,
    required this.mainStock,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
        rep: parseImages(json),
        invs: parseData(json),
        dets: parseDataDet(json),
        heads: parseDataHead(json),
        pchDets: parseDataPchDet(json),
        mainStock: parseDataMainStock(json));
  }

  static List<RepRow> parseImages(imageJson) {
    var list = [];
    if (imageJson?['unitlst'] != null) {
      list = imageJson?['unitlst'] as List;
    }
    if (imageJson?['catelst'] != null) {
      list = imageJson?['catelst'] as List;
    }
    if (imageJson?['vendorlst'] != null) {
      list = imageJson?['vendorlst'] as List;
    }
    if (imageJson?['acclst'] != null) {
      list = imageJson?['acclst'] as List;
    }
    List<RepRow> imageList = list.map((data) => RepRow.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }

  static List<InvoiceModel> parseData(imageJson) {
    var list = [];
    // if (imageJson?['templst'] != null) {
    //   list = imageJson?['templst'] as List;
    // }
    if (imageJson?['headtemplst'] != null) {
      list = imageJson?['headtemplst'] as List;
    }
    List<InvoiceModel> imageList =
        list.map((data) => InvoiceModel.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }

  static List<TempDet> parseDataDet(imageJson) {
    var list = [];
    if (imageJson?['templst'] != null) {
      list = imageJson?['templst'] as List;
    }
    List<TempDet> imageList =
        list.map((data) => TempDet.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }

  static List<HeadModel> parseDataHead(imageJson) {
    var list = [];
    if (imageJson?['head-lst'] != null) {
      list = imageJson?['head-lst'] as List;
    }
    List<HeadModel> imageList =
        list.map((data) => HeadModel.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }

  static List<PchDet> parseDataPchDet(imageJson) {
    var list = [];
    if (imageJson?['detail-lst'] != null) {
      list = imageJson?['detail-lst'] as List;
    }
    List<PchDet> imageList = list.map((data) => PchDet.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }

  static List<MainStock> parseDataMainStock(imageJson) {
    var list = [];
    if (imageJson?['ava-lst'] != null) {
      list = imageJson?['ava-lst'] as List;
    }
    if (imageJson?['no-ava-lst'] != null) {
      list = imageJson?['no-ava-lst'] as List;
    }
    if (imageJson?['price-lst'] != null) {
      list = imageJson?['price-lst'] as List;
    }
    List<MainStock> imageList =
        list.map((data) => MainStock.fromJson(data)).toList();
    //  debugPrint('$imageList');
    return imageList;
  }
}

class ResponseObject {
  final Result result;
  final Data data;

  ResponseObject({required this.result, required this.data});

  factory ResponseObject.fromJson(Map<String, dynamic>? json) {
    return ResponseObject(
        result: Result.fromJson(json?['result']),
        data: Data.fromJson(json?['data']));
  }
}

// class ResponseTest {
//   final List<TempDet> data;
//   ResponseTest({required this.data});
//   factory ResponseTest.fromJson(Map<String, dynamic>? json) {
//     return ResponseTest(data: parseData(json));
//   }
//   static List<TempDet> parseData(imageJson) {
//     var list = [];
//     // if (imageJson?['detlst'] != null) {
//     //   list = imageJson?['detlst'] as List;
//     // }
//     List<TempDet> imageList =
//         list.map((data) => TempDet.fromJson(data)).toList();
//     //  debugPrint('$imageList');
//     return imageList;
//   }
// }

class InvoiceModel {
  final String createdAt;
  final int id;
  final int vendorId;
  final int state;
  final int flag;
  final double total;
  final double discount;
  bool isSelected = false;

  InvoiceModel({
    required this.id,
    required this.vendorId,
    required this.flag,
    required this.state,
    required this.discount,
    required this.total,
    required this.createdAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic>? json) {
    String createdAt = json?['createdAt'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int flag = int.parse(json?['flag']?.toString() ?? '0');
    int state = int.parse(json?['state']?.toString() ?? '0');
    int vendorId = int.parse(json?['vendor_id']?.toString() ?? '0');
    double total = double.parse(json?['total']?.toString() ?? '0');
    double discount = double.parse(json?['discount']?.toString() ?? '0');

    return InvoiceModel(
        createdAt: createdAt,
        id: id,
        discount: discount,
        flag: flag,
        total: total,
        state: state,
        vendorId: vendorId);
  }
}

class HeadModel {
  final String createdAt;
  final int id;
  final int vendorId;
  final String vendor;
  final int temp;
  final double total;
  final double discount;

  HeadModel({
    required this.id,
    required this.vendorId,
    required this.vendor,
    required this.temp,
    required this.discount,
    required this.total,
    required this.createdAt,
  });

  factory HeadModel.fromJson(Map<String, dynamic>? json) {
    String createdAt = json?['created_at'] ?? '';
    String vendor = json?['vendor'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int temp = int.parse(json?['temp']?.toString() ?? '0');
    int vendorId = int.parse(json?['vendor_id']?.toString() ?? '0');
    double total = double.parse(json?['total']?.toString() ?? '0');
    double discount = double.parse(json?['discount']?.toString() ?? '0');

    return HeadModel(
        createdAt: createdAt,
        id: id,
        temp: temp,
        vendor: vendor,
        discount: discount,
        total: total,
        vendorId: vendorId);
  }
}
