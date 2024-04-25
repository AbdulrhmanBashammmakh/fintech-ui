class Check {
  static int pin = -1;
}

class Invoice {
  final double total;
  final double discount;
  final int flag;
  final int vendor;

  Invoice(
      {required this.total,
      required this.discount,
      required this.flag,
      required this.vendor});

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "discount": discount,
      "flag": flag,
      "vendor_id": vendor
    };
  }
}

class InvoiceSale {
  final double total;
  final double discount;
  final String customer;

  InvoiceSale(
      {required this.total, required this.discount, required this.customer});

  Map<String, dynamic> toJson() {
    return {"total": total, "discount": discount, "customer": customer};
  }
}

class Item {
  final double price;
  final double amt;
  final String name;
  final String code;
  final int cate;
  final int qty;
  final int unit;

  Item(this.price, this.amt, this.name, this.code, this.cate, this.qty,
      this.unit);

  Map<String, dynamic> toJson() {
    return {
      "cate": cate,
      "unit": unit,
      "name": name,
      "code": code,
      "price": price,
      "qty": qty,
      "amt": amt
    };
  }
}

class ItemSale {
  final double price;
  final double amt;
  // final String name;
  final String code;
  // final int cate;
  final int qty;
  // final int id;

  ItemSale(
      {required this.price,
      required this.amt,
      required this.qty,
      required this.code});
  // this.name, this.code, this.cate,
  Map<String, dynamic> toJson() {
    return {
      // "cate": cate,
      // "unit": unit,
      // "name": name,
      "code": code,
      "price": price,
      "qty": qty,
      "amt": amt
    };
  }
}

class MainStock {
  final int id;
  final String code;
  final String barcode;
  final String createdAt;
  final int cateId;
  final String cate;

  final double cost;
  final double lastBuy;
  final double salePrice;
  final String product;

  final int qty;
  final String unit;

  MainStock(
      {required this.barcode,
      required this.createdAt,
      required this.cateId,
      required this.code,
      required this.cate,
      required this.qty,
      required this.unit,
      required this.cost,
      required this.lastBuy,
      required this.salePrice,
      required this.product,
      required this.id});
  bool isEqual(MainStock? model) {
    return id == model?.id;
  }

  Map<String, dynamic> toJson() {
    return {
      "cate": cate,
      "unit": unit,
      "id": id,
      "code": code,
      "product": product,
      "qty": qty,
      "barcode": barcode,
      "cate_id": code,
      "created_at": createdAt,
      "last_buy": lastBuy,
      "sale_price": salePrice,
      "cost": cost,
    };
  }

  factory MainStock.fromJson(Map<String, dynamic>? json) {
    String createdAt = json?['created_at'] ?? '';
    String code = json?['code'] ?? '';
    String barcode = json?['barcode'] ?? '';
    String product = json?['product'] ?? '';
    String cate = json?['cate'] ?? '';
    String unit = json?['unit'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int cateId = int.parse(json?['cate_id']?.toString() ?? '0');
    int qty = int.parse(json?['qty']?.toString() ?? '0');
    double lastBuy = double.parse(json?['last_buy']?.toString() ?? '0');
    double salePrice = double.parse(json?['sale_price']?.toString() ?? '0');
    double cost = double.parse(json?['cost']?.toString() ?? '0');

    return MainStock(
        createdAt: createdAt,
        id: id,
        unit: unit,
        qty: qty,
        cate: cate,
        code: code,
        barcode: barcode,
        cateId: cateId,
        cost: cost,
        lastBuy: lastBuy,
        product: product,
        salePrice: salePrice);
  }
}

class TempDet {
  final double amt;
  final double price;
  final String name;
  final String code;
  final String barcode;

  // final String nameOwn;
  final int qty;
  final int invoice;
  final int id;
  final int cate;
  final int unit;

  TempDet({
    required this.amt,
    required this.price,
    required this.id,
    required this.invoice,
    required this.name,
    // required this.nameOwn,
    required this.cate,
    required this.code,
    required this.qty,
    required this.barcode,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cate": cate,
      "unit": unit,
      "name": name,
      "code": code,
      "barcode": barcode,
      // "nameOwn": nameOwn,
      "price": price,
      "amt": amt,
      "tempId": invoice,
      "qty": qty
    };
  }

  factory TempDet.fromJson(Map<String, dynamic>? json) {
    String name = json?['name'] ?? '';
    //  String nameOwn = json?['nameOwn'] ?? '';
    String code = json?['code'] ?? '';
    String barcode = json?['barcode'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int invoice = int.parse(json?['tempId']?.toString() ?? '0');
    int qty = int.parse(json?['qty']?.toString() ?? '0');
    int cate = int.parse(json?['cate']?.toString() ?? '0');
    int unit = int.parse(json?['unit']?.toString() ?? '0');
    double amt = double.parse(json?['amt']?.toString() ?? '0');
    double price = double.parse(json?['price']?.toString() ?? '0');

    return TempDet(
        amt: amt,
        price: price,
        id: id,
        invoice: invoice,
        name: name,
        // nameOwn: nameOwn,
        cate: cate,
        code: code,
        qty: qty,
        barcode: barcode,
        unit: unit);
  }
}

class PchDet {
  final double amt;
  final double price;
  final String name;
  final int productId;
  final String code;
  final String barcode;
  final int qty;
  final int id;
  final String cate;
  final int head;
  final int cateId;
  final String unit;

  PchDet({
    required this.amt,
    required this.price,
    required this.id,
    required this.name,
    required this.cate,
    required this.cateId,
    required this.head,
    required this.code,
    required this.qty,
    required this.barcode,
    required this.unit,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cate": cate,
      "unit": unit,
      "name": name,
      "code": code,
      "barcode": barcode,
      // "nameOwn": nameOwn,
      "price": price,
      "amt": amt,
      "head": head,
      "qty": qty
    };
  }

  factory PchDet.fromJson(Map<String, dynamic>? json) {
    String name = json?['product'] ?? '';
    String cate = json?['cate'] ?? '';
    String code = json?['code'] ?? '';
    String barcode = json?['barcode'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int productId = int.parse(json?['product_id']?.toString() ?? '0');
    int cateId = int.parse(json?['cate_id']?.toString() ?? '0');
    int invoice = int.parse(json?['head']?.toString() ?? '0');
    int qty = int.parse(json?['qty']?.toString() ?? '0');
    String unit = json?['unit'] ?? '';
    double amt = double.parse(json?['amt']?.toString() ?? '0');
    double price = double.parse(json?['price']?.toString() ?? '0');

    return PchDet(
        amt: amt,
        price: price,
        id: id,
        head: invoice,
        name: name,
        cateId: cateId,
        productId: productId,
        cate: cate,
        code: code,
        qty: qty,
        barcode: barcode,
        unit: unit);
  }
}

class Vendor {
  final String address;
  final String phone;
  final String name;
  final int id;

  Vendor({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "address": address,
      "phone": phone,
      "name": name,
    };
  }

  factory Vendor.fromJson(Map<String, dynamic>? json) {
    String name = json?['name'] ?? '';
    String address = json?['address'] ?? '';
    String phone = json?['phone'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');

    return Vendor(
      address: address,
      phone: phone,
      id: id,
      name: name,
    );
  }
}

class Cate {
  final String name;
  final int id;

  Cate({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  factory Cate.fromJson(Map<String, dynamic>? json) {
    String name = json?['name'] ?? '';
    // String address = json?['address'] ?? '';
    // String phone = json?['phone'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');

    return Cate(
      id: id,
      name: name,
    );
  }
}

class UpdatePrice {
  final double cost;
  final double price;
  final int id;

  UpdatePrice({
    required this.id,
    required this.cost,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cost": cost,
      "sale_price": price,
    };
  }

  factory UpdatePrice.fromJson(Map<String, dynamic>? json) {
    int id = int.parse(json?['id']?.toString() ?? '0');
    double cost = double.parse(json?['cost']?.toString() ?? '0');
    double price = double.parse(json?['sale_price']?.toString() ?? '0');

    return UpdatePrice(id: id, price: price, cost: cost);
  }
}
