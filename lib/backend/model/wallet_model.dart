class WalletModel {
  int? success;
  String? message;
  Data? data;

  WalletModel({this.success, this.message, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? walletAmount;
  List<TransactionHistory>? transactionhistory;


  Data(
      {
        this.id,
        this.walletAmount,
        this.transactionhistory,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletAmount = json['walletamount'];

    if (json['transactionhistory'] != null) {
      transactionhistory = <TransactionHistory>[];
      json['transactionhistory'].forEach((v) {
        transactionhistory?.add(TransactionHistory.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletamount'] = walletAmount;

    if (transactionhistory != null) {
      data['transactionhistory'] =
          transactionhistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  int? id;

  TransactionHistory(
      {
        this.id,
      });

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }

}






