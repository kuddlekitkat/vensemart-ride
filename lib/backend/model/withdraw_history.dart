class WithdrawHistoryModel {
  int? success;
  String? message;
  Data? data;

  WithdrawHistoryModel({this.success, this.message, this.data});

  WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
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
  dynamic? walletAmount;
  dynamic? cWalletAmount;
  List<WalletHistory>? wallethistory;



  // List<dynamic>? requests;



  Data(
      {
        this.id,
        this.walletAmount,
        this.cWalletAmount,
        this.wallethistory,


      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletAmount = json['walletamount'];
    cWalletAmount = json['c_walletamount'];



    // totalRequests = json['total_requests'];
    // if (json['requests'] != null) {
    //   requests = <Requests>[];
    //   json['requests'].forEach((v) {
    //     requests!.add(Requests.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletamount'] = walletAmount;
    data['c_walletamount'] = cWalletAmount;


    // if (requests != null) {
    //   data['requests'] =
    //       requests!.map((v) => v).toList();
    // }
    return data;
  }
}

class WalletHistory {
  int? id;

  WalletHistory(

  {
  this.id,

  });

  WalletHistory.fromJson(Map<String, dynamic> json) {
     id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }


}






