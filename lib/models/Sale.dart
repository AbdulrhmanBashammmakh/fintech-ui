class SaleHead {
  final int id;
  final String createdAt;
  final double discount;
  final String customer;
  final double total;

  SaleHead({
    required this.id,
    required this.createdAt,
    required this.discount,
    required this.total,
    required this.customer,
  });

  factory SaleHead.fromJson(Map<String, dynamic>? json) {
    String createdAt = json?['created_at'] ?? '';
    String customer = json?['customer'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    double total = double.parse(json?['total']?.toString() ?? '0');
    double discount = double.parse(json?['discount']?.toString() ?? '0');

    return SaleHead(
      createdAt: createdAt,
      id: id,
      customer: customer,
      discount: discount,
      total: total,
    );
  }
}

class SaleDet {
  final int id;
  final int qty;
  final int cateId;
  final int saleId;
  final String cate;
  final double amt;
  final String unit;
  final String product;
  final String code;
  final String barcode;
  final double price;

  SaleDet({
    required this.id,
    required this.qty,
    required this.cate,
    required this.amt,
    required this.price,
    required this.cateId,
    required this.saleId,
    required this.unit,
    required this.product,
    required this.code,
    required this.barcode,
  });

  factory SaleDet.fromJson(Map<String, dynamic>? json) {
    String cate = json?['cate'] ?? '';
    String code = json?['code'] ?? '';
    String product = json?['product'] ?? '';
    String barcode = json?['barcode'] ?? '';
    String unit = json?['unit'] ?? '';
    int id = int.parse(json?['id']?.toString() ?? '0');
    int qty = int.parse(json?['qty']?.toString() ?? '0');
    int cateId = int.parse(json?['cate_id']?.toString() ?? '0');
    int saleId = int.parse(json?['sale_id']?.toString() ?? '0');
    double price = double.parse(json?['price']?.toString() ?? '0');
    double amt = double.parse(json?['amt']?.toString() ?? '0');

    return SaleDet(
        cate: cate,
        qty: qty,
        id: id,
        amt: amt,
        price: price,
        code: code,
        product: product,
        cateId: cateId,
        barcode: barcode,
        unit: unit,
        saleId: saleId);
  }
}
