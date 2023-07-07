

class Product {
  int? id;
  int? status;
  int? stockId;
  int? hasDiscount;
  String? name;
  double? volume;
  String? type;
  String? unit;
  double? sellingPrice;

  Product({
    this.id,
    this.status,
    this.stockId,
    this.name,
    this.volume,
    this.type,
    this.unit,
    this.sellingPrice,
    this.hasDiscount,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    stockId = json['stock_id'];
    name = json['name'];
    volume = json['volume'].toDouble();
    type = json['type'];
    unit = json['unit'];
    sellingPrice = json['selling_price'].toDouble();
    hasDiscount = json['has_discount'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    data['volume'] = volume;
    data['type'] = type;
    data['unit'] = unit;
    data['sellingPrice'] = sellingPrice;
    data['hasDiscount'] = hasDiscount;

    return data;
  }
}
