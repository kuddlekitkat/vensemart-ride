class BankDetail {
  int? status;
  String? message;
  List<Data>? data;

  BankDetail({this.status, this.message, this.data});

  BankDetail.fromJson(Map<String, dynamic> json) {
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
  String? bank;
  String? ifsc;
  String? micro_code;
  String? branch;
  String? accountNumber;
  String? accountHolderName;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.bank,
        this.ifsc,
        this.micro_code,
        this.branch,
        this.accountHolderName,
        this.accountNumber,
        this.createdAt,
        this.updatedAt
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    ifsc = json['ifsc'];
    micro_code = json['micro_code'];
    branch = json['branch'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank'] = bank;
    data['ifsc'] = ifsc;
    data['micro_code'] = micro_code;
    data['branch'] = branch;
    data['account_number'] = accountNumber;
    data['account_holder_name'] = accountHolderName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
