class SingleOrderModel {
  Data? data;
  String? message;
  int? status;

  SingleOrderModel({this.data, this.message, this.status});

  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];

    status = json['status'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   data['message'] = message;
  //   data['status'] = status;
  //   return data;
  // }
}

class Data {
  int? id;
  String? orderCode;
  String? total;
  String? name;
  String? email;
  String? address;
  String? governorate;
  String? phone;
  String? subTotal;
  String? orderDate;
  String? status;

  int? discount;
  List<OrderProducts>? orderProducts;

  Data(
      {this.id,
      this.orderCode,
      this.total,
      this.name,
      this.email,
      this.address,
      this.governorate,
      this.phone,
      this.subTotal,
      this.orderDate,
      this.status,
      this.discount,
      this.orderProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    total = json['total'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    governorate = json['governorate'];
    phone = json['phone'];
    subTotal = json['sub_total'];
    orderDate = json['order_date'];
    status = json['status'];
    discount = json['discount'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['order_code'] = orderCode;
  //   data['total'] = total;
  //   data['name'] = name;
  //   data['email'] = email;
  //   data['address'] = address;
  //   data['governorate'] = governorate;
  //   data['phone'] = phone;
  //   data['sub_total'] = subTotal;
  //   data['order_date'] = orderDate;
  //   data['status'] = status;
  //   data['discount'] = discount;
  //   if (orderProducts != null) {
  //     data['order_products'] =
  //         orderProducts!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class OrderProducts {
  int? orderProductId;
  int? productId;
  String? productName;
  String? productPrice;
  int? productDiscount;
  double? productPriceAfterDiscount;
  int? orderProductQuantity;
  String? productTotal;

  OrderProducts(
      {this.orderProductId,
      this.productId,
      this.productName,
      this.productPrice,
      this.productDiscount,
      this.productPriceAfterDiscount,
      this.orderProductQuantity,
      this.productTotal});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    orderProductId = json['order_product_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productPriceAfterDiscount = json['product_price_after_discount'];
    orderProductQuantity = json['order_product_quantity'];
    productTotal = json['product_total'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['order_product_id'] = orderProductId;
  //   data['product_id'] = productId;
  //   data['product_name'] = productName;
  //   data['product_price'] = productPrice;
  //   data['product_discount'] = productDiscount;
  //   data['product_price_after_discount'] = productPriceAfterDiscount;
  //   data['order_product_quantity'] = orderProductQuantity;
  //   data['product_total'] = productTotal;
  //   return data;
  // }
}
