class ServiceHomeModel {
  int? success;
  String? message;
  Data? data;

  ServiceHomeModel({this.success, this.message, this.data});

  ServiceHomeModel.fromJson(Map<String, dynamic> json) {
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
  dynamic totalOrder;
  dynamic totalEarning;
  dynamic todayOrder;
  bool? availability;
  dynamic pendingOrder;
  dynamic completedOrder;
  // List<dynamic>? requests;



  Data(
      {this.totalOrder,
        this.totalEarning,
        this.todayOrder,
        this.availability,
        this.pendingOrder,
        this.completedOrder
      });

  Data.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    totalEarning = json['total_earning'];
    todayOrder = json['today_order'];
    availability = json['availability'];
    pendingOrder = json['pending_order'];
    completedOrder = json['completed_order'];

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
    data['total_order'] = totalOrder;
    data['total_earning'] = totalEarning;
    data['today_orders'] = todayOrder;
    data['availability'] = availability;
    data['pending_order'] = pendingOrder;
    data['completed_order'] = completedOrder;

    // if (requests != null) {
    //   data['requests'] =
    //       requests!.map((v) => v).toList();
    // }
    return data;
  }
}

class Requests {
  dynamic id;
  String? bookingId;
  String? userId;
  String? serviceProId;
  String? serviceType;
  dynamic description;
  dynamic userAddress;
  dynamic userLat;
  dynamic userLong;
  String? bookingDate;
  String? bookingTime;
  String? price;
  dynamic status;
  dynamic cancelReason;
  dynamic paymentStatus;
  dynamic transactionId;
  dynamic paymentMode;
  dynamic mobileNumber;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? email;
  String? mobile;
  String? categoryName;

  Requests({
    this.id,
    this.bookingId,
    this.userId,
    this.serviceProId,
    this.serviceType,
    this.description,
    this.userAddress,
    this.userLat,
    this.userLong,
    this.bookingDate,
    this.bookingTime,
    this.price,
    this.status,
    this.cancelReason,
    this.paymentStatus,
    this.transactionId,
    this.paymentMode,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.mobile,
    this.categoryName,
  });

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json["booking_id"];
    userId = json["user_id"];
    serviceProId = json["service_pro_id"];
    serviceType =  json["service_type"];
    description = json["description"];
    userAddress = json["user_address"];
    userLat = json["user_lat"];
    userLong = json["user_long"];
    bookingDate = json["booking_date"];
    bookingTime = json["booking_time"];
    price = json["price"];
    status = json["status"];
    cancelReason = json["cancel_reason"];
    paymentStatus = json["payment_status"];
    transactionId = json["transaction_id"];
    paymentMode = json["payment_mode"];
    mobileNumber = json["mobile_number"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    name = json["name"];
    email = json["email"];
    mobile = json["mobile"];
    categoryName = json["category_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['user_id'] = userId;
    data['service_pro_id'] = serviceProId;
    data['service_type'] = serviceType;
    data['description'] = description;
    data['user_address'] = userAddress;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['booking_date'] = bookingDate;
    data['booking_time'] = bookingTime;
    data['price'] = price;
    data['status'] = status;
    data['cancel_reason'] = cancelReason;
    data['payment_status'] = paymentStatus;
    data['transaction_id'] = transactionId;
    data['payment_mode'] = paymentMode;
    data['mobile_number'] = mobileNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['category_name'] = categoryName;
    return data;
  }
}