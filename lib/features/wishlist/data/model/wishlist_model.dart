class WishlistModel {
  Data? data;
  String? message;
  int? status;

  WishlistModel({this.data, this.message, this.status});

  WishlistModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<ItemData>? itemData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.itemData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      itemData = <ItemData>[];
      json['data'].forEach((v) {
        itemData!.add(ItemData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (itemData != null) {
      data['data'] = itemData!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ItemData {
  int? id;
  String? name;
  String? price;
  String? category;
  String? image;
  int? discount;
  int? stock;
  String? description;
  int? bestSeller;

  ItemData(
      {this.id,
      this.name,
      this.price,
      this.category,
      this.image,
      this.discount,
      this.stock,
      this.description,
      this.bestSeller});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
    discount = json['discount'];
    stock = json['stock'];
    description = json['description'];
    bestSeller = json['best_seller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['category'] = category;
    data['image'] = image;
    data['discount'] = discount;
    data['stock'] = stock;
    data['description'] = description;
    data['best_seller'] = bestSeller;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
