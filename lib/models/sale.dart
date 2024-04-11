import 'package:vegafruits/models/good.dart';

class Sale {
  int? id;
  int? userId;
  int? customerId;
  String? seller;
  String? date;
  double? amountPaid;
  List<Good>? goods;

  Sale({
    this.id,
    this.userId,
    this.customerId,
    this.seller,
    this.date,
    this.amountPaid,
    this.goods,
  });

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    seller = json['seller'];
    date = json['date'];
    amountPaid = json['amount_paid'].toDouble();
    goods = (json['goods'] as List<dynamic>?)
        ?.map((good) => Good.fromJson(good))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['customerId'] = customerId;
    data['seller'] = seller;
    data['date'] = date;
    data['amountPaid'] = amountPaid;
    data['goods'] = goods?.map((good) => good.toJson()).toList();

    return data;
  }
}
