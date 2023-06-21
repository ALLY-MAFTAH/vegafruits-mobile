class Customer {
  int? id;
  String? mobile;
  String? name;

  Customer({
    this.id,
    this.name,
    this.mobile,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;

    return data;
  }
}
