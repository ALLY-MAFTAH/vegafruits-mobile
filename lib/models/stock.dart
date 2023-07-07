import 'package:vegafruits/models/product.dart';

class Stock {
  int? id;
  int? status;
  String? name;
  double? quantity;
  String? type;
  String? unit;
  double? buyingPrice;
  Product? product;

  Stock({
    this.id,
    this.status,
    this.name,
    this.quantity,
    this.type,
    this.unit,
    this.buyingPrice,
    this.product,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    quantity = json['quantity'].toDouble();
    type = json['type'];
    unit = json['unit'];
    buyingPrice = json['buying_price'].toDouble() ;
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    data['quantity'] = quantity;
    data['type'] = type;
    data['unit'] = unit;
    data['buyingPrice'] = buyingPrice;
    data['product'] = product?.toJson();

    return data;
  }
}
