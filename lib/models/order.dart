import 'package:vegafruits/models/customer.dart';
import 'item.dart';

class Order {
  int? id;
  int? status;
  int? isPaid;
  int? wasContacted;
  int? customerId;
  String? number;
  String? date;
  String? servedBy;
  String? servedDate;
  double? totalAmount;
  String? deliveryTime;
  String? deliveryDate;
  String? deliveryLocation;
  Customer? customer;
  List<Item>? items;

  Order({
    this.id,
    this.status,
    this.isPaid,
    this.wasContacted,
    this.number,
    this.date,
    this.customerId,
    this.servedBy,
    this.servedDate,
    this.totalAmount,
    this.deliveryTime,
    this.deliveryDate,
    this.deliveryLocation,
    this.customer,
    this.items,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    status = json['status'];
    isPaid = json['is_paid'];
    wasContacted = json['was_contacted'];
    date = json['date'];
    customerId = json['customer_id'];
    servedBy = json['served_by'];
    servedDate = json['served_date'];
    totalAmount = json['total_amount']?.toDouble();
    deliveryTime = json['delivery_time'];
    deliveryDate = json['delivery_date'];
    deliveryLocation = json['delivery_location'];
    customer = Customer.fromJson(json['customer']);
    items = (json['items'] as List<dynamic>?)
        ?.map((item) => Item.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['status'] = status;
    data['isPaid'] = isPaid;
    data['wasContacted'] = wasContacted;
    data['number'] = number;
    data['date'] = date;
    data['customerId'] = customerId;
    data['servedBy'] = servedBy;
    data['servedDate'] = servedDate;
    data['totalAmount'] = totalAmount;
    data['deliveryTime'] = deliveryTime;
    data['deliveryDate'] = deliveryDate;
    data['deliveryLocation'] = deliveryLocation;
    data['customer'] = customer?.toJson();
    data['items'] = items?.map((item) => item.toJson()).toList();

    return data;
  }
}
