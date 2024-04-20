import 'package:fintech/models/Sale.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

Future<List<SaleHead>?> saleDbHead() async {
  final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: "admin",
      password: "admin",
      databaseName: "fintech",
      secure: false // optional
      );

  await conn.connect();

  var result =
      await conn.execute("SELECT * FROM `sale_head` ORDER BY created_at DESC");

  List<SaleHead>? list;
  List<dynamic> myList = [];
  Map<String, dynamic>? a;
  for (final row in result.rows) {
    // a = row.assoc();
    // double? dis = row.typedColByName<double>("discount");
    // debugPrint("$dis");
    // double? tot = row.typedColByName<double>("total");
    // debugPrint("$tot");
    // int? id = row.typedColByName<int>("id");
    // debugPrint("$id");
    // String? cr = row.typedColByName<String>("created_at");
    // debugPrint("$cr");
    // var x = SaleHead(discount: dis!, createdAt: cr!, id: id!, total: tot!);
    // list!.add(x);
    // list?.add(x);
    // Each row is a Map<String, dynamic>
  }
  result.rowsStream.listen((row) {
    double? dis = row.typedColByName<double>("discount");
    debugPrint("$dis");
    double? tot = row.typedColByName<double>("total");
    debugPrint("$tot");
    int? id = row.typedColByName<int>("id");
    debugPrint("$id");
    String? cr = row.typedColByName<String>("created_at");
    debugPrint("$cr");
    var x = SaleHead(discount: dis!, createdAt: cr!, id: id!, total: tot!);
    myList.add(x);
  });
  // a!.forEach((key, value) {
  //   list!.add(SaleHead(
  //       discount: value['discount'],
  //       createdAt: value['created_at'],
  //       id: value['id'],
  //       total: value['total']));
  // });

  debugPrint("${myList}");
  list = myList.cast<SaleHead>();
  await conn.close();
  return list;
}
