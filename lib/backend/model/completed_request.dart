class CompletedRequestModel {
  int? status;
  String? message;
  List<Data>? data;

  CompletedRequestModel({this.status, this.message, this.data});

  CompletedRequestModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  String? bookingId;
  dynamic userId;
  int? rideRequestId;
  String? serviceProId;
  String? serviceType;
  dynamic description;
  dynamic userAddress;
  dynamic userMobile;
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
  String? storeName;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? rideStartAddress;
  String? rideEndAddress;
  String? rideStartLatitude;
  String? rideStartLongitude;
  String? rideDeliveryLatitude;
  String? rideDeliveryLongitude;
  String? rideType;
  String? itemType;
  String? itemCategories;
  String? deliveryAddress;
  String? deliveryLatitude;
  String? deliveryLongitude;
  String? deliveryMobile;
  String? otherRiderName;
  String? otherRiderPhoneNumber;

  Data({
    this.id,
    this.bookingId,
    this.userId,
    this.rideRequestId,
    this.serviceProId,
    this.serviceType,
    this.description,
    this.userAddress,
    this.userMobile,
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
    this.storeName,
    this.storeAddress,
    this.storeLatitude,
    this.storeLongitude,
    this.rideStartAddress,
    this.rideEndAddress,
    this.rideStartLatitude,
    this.rideStartLongitude,
    this.rideDeliveryLatitude,
    this.rideDeliveryLongitude,
    this.rideType,
    this.itemType,
    this.itemCategories,
    this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    this.deliveryMobile,
    this.otherRiderName,
    this.otherRiderPhoneNumber,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json["booking_id"];
    userId = json["user_id"];
    rideRequestId = json["ride_request_id"];
    serviceProId = json["service_pro_id"];
    serviceType = json["service_type"];
    description = json["description"];
    userAddress = json["user_address"];
    userMobile = json["user_mobile"];
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
    storeName = json["store_name"];
    storeAddress = json["store_address"];
    storeLatitude = json["store_latitude"];
    storeLongitude = json["store_longitude"];
    rideStartAddress = json["ride_start_address"];
    rideEndAddress = json["ride_end_address"];
    rideStartLatitude = json["ride_start_latitude"];
    rideStartLongitude = json["ride_start_longitude"];
    rideDeliveryLatitude = json["ride_delivery_latitude"];
    rideDeliveryLongitude = json["ride_delivery_longitude"];
    rideType = json["ride_type"];
    itemType = json["item_type"];
    itemCategories = json["item_categories"];
    deliveryAddress = json["delivery_address"];
    deliveryLongitude = json["delivery_address"];
    deliveryLatitude = json["delivery_latitude"];
    deliveryMobile = json["delivery_mobile"];
    otherRiderName = json["other_rider_name"];
    otherRiderPhoneNumber = json["other_rider_phone_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['user_id'] = userId;
    data['ride_request_id'] = rideRequestId;
    data['service_pro_id'] = serviceProId;
    data['service_type'] = serviceType;
    data['description'] = description;
    data['user_address'] = userAddress;
    data['user_mobile'] = userMobile;
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
    data['store_name'] = storeName;
    data['store_address'] = storeAddress;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['ride_start_address'] = rideStartAddress;
    data['ride_end_address'] = rideEndAddress;
    data['ride_start_latitude'] = rideStartLatitude;
    data['ride_start_longitude'] = rideStartLongitude;
    data['ride_delivery_latitude'] = rideDeliveryLatitude;
    data['ride_delivery_longitude'] = rideDeliveryLongitude;
    data['ride_type'] = rideType;
    data['item_type'] = itemType;
    data['item_categories'] = itemCategories;
    data['delivery_address'] = deliveryAddress;
    data['delivery_latitude'] = deliveryLatitude;
    data['delivery_longitude'] = deliveryLongitude;
    data['delivery_mobile'] = deliveryMobile;
    data['other_rider_name'] = otherRiderName;
    data['other_rider_phone_number'] = otherRiderPhoneNumber;

    return data;
  }
}

