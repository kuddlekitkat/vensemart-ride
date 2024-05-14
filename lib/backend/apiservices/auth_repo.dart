import 'package:dio/dio.dart';

import 'api_services.dart';

class AuthRepo with ApiServices {
  Future<Response?> login(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("rider/login", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> register(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("rider/register", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> sendOtp(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("send-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> verifyOtp(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("verify-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> deleteAccount(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("delete-account", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> updateProfile(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiUploadPostRequests("update_profile", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> sendPasswordChange(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("forgot-password", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  // ignore: non_constant_identifier_names
  Future<Response?> LocationSet(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("set-location", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> verifyWithBvn(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("verify-bvn", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> verifyBvnNumber(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("verify-bvn-number", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  // ignore: non_constant_identifier_names
  Future<Response?> ChangeCredentials(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service_update_profile", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> changePassword(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("forgot-password-change", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> serviceHome() async {
    Response? response = await apiGetRequests(
      "rider/home",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> allOrders() async {
    Response? response = await apiGetRequests(
      "rider/all-orders",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> bankList() async {
    Response? response = await apiGetRequests(
      "get-banks",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getBankDetails() async {
    Response? response = await apiGetRequests(
      "rider/get-bank-details",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  // changeOnlineStatus
  Future<Response?> changeOnlineStatus() async {
    Response? response = await apiGetRequests("service-online-status");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> addBankDetails(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/add-bank-details", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> validateBankDetails(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("validate-bank-account", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> getUserDetails() async {
    Response? response = await apiGetRequests("rider/get-profile");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> serviceId(String? num) async {
    Response? response = await apiGetRequests("service-provider/$num");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> services() async {
    Response? response = await apiGetRequests("services");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> acceptRejectBooking(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("accept-reject-bookings", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> completeBookingN(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/complete_order_no_otp", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> endBooking(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("complete-reject-booking", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> sendSupport(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("send-support-message", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> goOnline(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service-online-status", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> goOffline(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service-offline-status", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> verifyUser(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service-provider-verify-number", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> sendSupportMessage(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("send-support-message", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> rateCustomer(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rate-service-provider", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> upcomingRequest() async {
    Response? response = await apiGetRequests(
      "rider/pending-orders",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> totalRequests() async {
    Response? response = await apiGetRequests(
      "rider/all-orders",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> acceptOrder(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/accept_order", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> rejectOrder(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/reject_order", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> updateOrder(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/update_order_status", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> makeWithdrawal(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/withdraw-request", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> walletHistory() async {
    Response? response = await apiGetRequests(
      "rider/wallet-history",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> rideHistory(int status) async {
    Response? response = await apiGetRequests(
      "rider/my-orders?status=$status",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> sendUserSms(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/complete_order_sms", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> validateOrder(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("rider/validate_order_details", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> canceledRequest() async {
    Response? response = await apiGetRequests(
      "rider/cancelled-orders",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  // ignore: non_constant_identifier_names
  Future<Response?> CompletedRequest() async {
    Response? response = await apiGetRequests(
      "rider/completed-orders",
    );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> userLocation() async {
    Response? response = await apiGetRequests("get-location");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> onboardRider(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiUploadPostRequests("rider/onBoardRider", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> sendLocation(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service-pro-onboarding-2", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> sendServiceId(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("service-pro-onboarding-1", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> providerPlans() async {
    Response? response = await apiGetRequests(
      "service_subscription_plans",
    );

    if (response != null) {
      return response;
    }

    return null;
  }
}
