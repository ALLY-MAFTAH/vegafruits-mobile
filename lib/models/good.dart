import 'package:vegafruits/models/customer.dart';

class Good {
  int? id;
  int? userId;
  int? goodId;
  int? stockId;
  int? productId;
  int? customerId;
  String? seller;
  String? name;
  String? volume;
  String? quantity;
  double? price;
  String? unit;
  String? date;
  String? type;
  Customer? customer;

  Good({
    this.id,
    this.userId,
    this.goodId,
    this.stockId,
    this.productId,
    this.customerId,
    this.seller,
    this.name,
    this.volume,
    this.quantity,
    this.price,
    this.date,
    this.unit,
    this.type,
    this.customer,
  });

  Good.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    goodId = json['good_id'];
    stockId = json['stock_id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    seller = json['seller'];
    name = json['name'];
    volume = json['volume'];
    quantity = json['quantity'];
    price = json['price'];
    date = json['date'];
    unit = json['unit'];
    type = json['unit'];
    customer = Customer.fromJson(json['customer']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;

    data['id'] = id;
    data['userId'] = userId;
    data['goodId'] = goodId;
    data['stockId'] = stockId;
    data['productId'] = productId;
    data['customerId'] = customerId;
    data['seller'] = seller;
    data['name'] = name;
    data['volume'] = volume;
    data['quantity'] = quantity;
    data['price'] = price;
    data['date'] = date;
    data['unit'] = unit;
    data['type'] = unit;

    data['customer'] = customer?.toJson();

    return data;
  }
}
