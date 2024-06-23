class OrderModel {
  Data? data;
  String? message;
  int? status;

  OrderModel({this.data, this.message, this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
   
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  User? user;
  String? total;
  List<CartItems>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    total = json['total'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['total'] = total;
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? userEmail;
  String? address;
  String? phone;

  User({this.userId, this.userName, this.userEmail, this.address, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductPrice;
  int? itemQuantity;
  String? itemTotal;

  CartItems(
      {this.itemId,
      this.itemProductId,
      this.itemProductName,
      this.itemProductPrice,
      this.itemQuantity,
      this.itemTotal});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductPrice = json['item_product_price'];
    itemQuantity = json['item_quantity'];
    itemTotal = json['item_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_product_id'] = itemProductId;
    data['item_product_name'] = itemProductName;
    data['item_product_price'] = itemProductPrice;
    data['item_quantity'] = itemQuantity;
    data['item_total'] = itemTotal;
    return data;
  }
}
