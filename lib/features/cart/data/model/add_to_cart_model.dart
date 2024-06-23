class AddCartModel {
  Data? data;
  String? message;
  int? status;

  AddCartModel({this.data, this.message, this.status});

  AddCartModel.fromJson(Map<String, dynamic> json) {
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

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    return data;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItems(
      {this.itemId,
      this.itemProductId,
      this.itemProductName,
      this.itemProductImage,
      this.itemProductPrice,
      this.itemProductDiscount,
      this.itemProductPriceAfterDiscount,
      this.itemProductStock,
      this.itemQuantity,
      this.itemTotal});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductImage = json['item_product_image'];
    itemProductPrice = json['item_product_price'];
    itemProductDiscount = json['item_product_discount'];
    itemProductPriceAfterDiscount = json['item_product_price_after_discount'];
    itemProductStock = json['item_product_stock'];
    itemQuantity = json['item_quantity'];
    // Response itemTotal(int) parse to double 
    itemTotal = json['item_total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_product_id'] = itemProductId;
    data['item_product_name'] = itemProductName;
    data['item_product_image'] = itemProductImage;
    data['item_product_price'] = itemProductPrice;
    data['item_product_discount'] = itemProductDiscount;
    data['item_product_price_after_discount'] =
        itemProductPriceAfterDiscount;
    data['item_product_stock'] = itemProductStock;
    data['item_quantity'] = itemQuantity;
    data['item_total'] = itemTotal;
    return data;
  }
}
