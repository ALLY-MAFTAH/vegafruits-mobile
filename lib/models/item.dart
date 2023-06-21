class Item {
  int? id;
  int? orderId;
  int? productId;
  int? stockId;
  String? name;
  String? type;
  String? unit;
  double? price;
  double? volume;
  double? quantity;

  Item({
    this.id,
    this.productId,
    this.stockId,
    this.orderId,
    this.name,
    this.type,
    this.unit,
    this.price,
    this.volume,
    this.quantity,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    stockId = json['stock_id'];
    orderId = json['order_id'];
    name = json['name'];
    type = json['type'];
    unit = json['unit'];
    price = json['price']?.toDouble();
    volume = json['volume']?.toDouble();
    quantity = json['quantity']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['stockId'] = stockId;
    data['orderId'] = orderId;
    data['unit'] = unit;
    data['name'] = name;
    data['type'] = type;
    data['price'] = price;
    data['volume'] = volume;
    data['quantity'] = quantity;
    return data;
  }
}
