class OrdersHistoryModel {
  Data? data;
  String? message;
  int? status;

  OrdersHistoryModel({this.data, this.message, this.status});

  OrdersHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Orders>? orders;
  Meta? meta;
  Links? links;

  Data({this.orders, this.meta, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (orders != null) {
  //     data['orders'] = orders!.map((v) => v.toJson()).toList();
  //   }
  //   if (meta != null) {
  //     data['meta'] = meta!.toJson();
  //   }
  //   if (links != null) {
  //     data['links'] = links!.toJson();
  //   }
  //   return data;
  // }
}

class Orders {
  int? id;
  String? orderCode;
  String? orderDate;
  String? status;
  String? total;

  Orders({this.id, this.orderCode, this.orderDate, this.status, this.total});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    orderDate = json['order_date'];
    status = json['status'];
    total = json['total'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['order_code'] = orderCode;
  //   data['order_date'] = orderDate;
  //   data['status'] = status;
  //   data['total'] = total;
  //   return data;
  // }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['total'] = total;
  //   data['per_page'] = perPage;
  //   data['current_page'] = currentPage;
  //   data['last_page'] = lastPage;
  //   return data;
  // }
}

class Links {
  String? first;
  String? last;


  Links({this.first, this.last,});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['first'] = first;
  //   data['last'] = last;
  //   return data;
  // }
}
