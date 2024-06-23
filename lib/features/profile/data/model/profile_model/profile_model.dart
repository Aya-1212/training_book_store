class ProfileModel {
  Data? data;
  String? message;
  int? status;

  ProfileModel({this.data, this.message, this.status});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
   
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    data['message'] = message;
  
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  Data(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.city,
      this.phone,
      this.emailVerified,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['name'] = name;
  //   data['email'] = email;
  //   data['address'] = address;
  //   data['city'] = city;
  //   data['phone'] = phone;
  //   data['email_verified'] = emailVerified;
  //   data['image'] = image;
  //   return data;
  // }
}
