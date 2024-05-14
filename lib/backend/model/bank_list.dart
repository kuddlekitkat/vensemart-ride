class BankList {
  int? status;
  String? message;
  List<Data>? data;

  BankList({this.status, this.message, this.data});

  BankList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  // bank: "Access Bank (Diamond)",
  // ifsc: null,
  // micro_code: "063",
  // branch: "",
  // user_id: "1006",
  // account_number: "1487007917",
  // account_holder_name: "Adamgbe Michael",
  // address: null,
  // contact: null,
  // city: null,
  // district: null,
  // state: null,
  // created_at: "2023-05-01T01:59:42.000000Z",
  // updated_at: "2023-05-01T01:59:42.000000Z"
  dynamic id;
  String? name;
  String? slug;
  String? code;
  String? longcode;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.slug,
        this.code,
        this.longcode,
        this.createdAt,
        this.updatedAt
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    longcode = json['longcode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['code'] = code;
    data['longcode'] = longcode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
