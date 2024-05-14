import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vensemart_delivery/backend/model/RiderListModel.dart';
import 'package:vensemart_delivery/backend/model/service_home_model.dart';
import 'package:vensemart_delivery/backend/model/service_provider_plans.dart';
import 'package:vensemart_delivery/backend/model/upcoming_request.dart';
import 'package:vensemart_delivery/backend/model/user_details_model.dart';
import 'package:vensemart_delivery/change_pass_screen.dart';
import 'package:vensemart_delivery/feedback_screen.dart';
import 'package:vensemart_delivery/index.dart';
import 'package:vensemart_delivery/main.dart';
import 'package:vensemart_delivery/trip_page_vendor.dart';
import '../../backend/apiservices/auth_lepo.dart';
import '../../backend/apiservices/auth_repo.dart';
import '../../backend/core/session_manager.dart';
import '../../backend/model/accept_reject_booking.dart';
import '../../backend/model/canceled_request.dart';
import '../../backend/model/completed_request.dart';
import '../../backend/model/entity.dart';
import '../../backend/model/general_model.dart';
import '../../backend/model/location_model.dart';
import '../../backend/model/login_model.dart';
import '../../backend/model/register_model.dart';
import '../../backend/model/service_id_model.dart';
import '../../backend/model/services_model.dart';
import '../backend/model/bank_details.dart';
import '../backend/model/bank_list.dart';
import '../backend/model/bank_model.dart';
import '../backend/model/total_request.dart';
import '../backend/model/wallet_model.dart';
import '../backend/model/withdraw_history.dart';
import '../home_page/home_page_widget.dart';
import '../nav_bar_page.dart';
import '../verify_page/OtpVerify.dart';

class ProviderServices extends ChangeNotifier {
  AuthRepo authRepo = AuthRepo();

  AuthLepo authLepo = AuthLepo();
  bool? get isLoading => _isLoading;
  bool? _isLoading;

  bool? get isSuccessful => _isSuccessful;
  bool? _isSuccessful;

  LoginModel? get loginModel => _loginModel;
  LoginModel? _loginModel;

  RegisterModel? get registerModel => _registerModel;
  RegisterModel? _registerModel;

  ServiceHomeModel? get serviceHomeModel => _serviceHhomeModel;
  ServiceHomeModel? _serviceHhomeModel;

  BankModel? get bankModel => _bankModel;
  BankModel? _bankModel;

  BankDetail? get bankDetail => _bankDetail;
  BankDetail? _bankDetail;

  BankList? get bankList => _bankList;
  BankList? _bankList;

  WalletModel? get walletModel => _walletModel;
  WalletModel? _walletModel;

  WithdrawHistoryModel? get withdrawHistoryModel => _withdrawHistoryModel;
  WithdrawHistoryModel? _withdrawHistoryModel;

  RideListModel? get rideHistoryModel => _rideHistoryModel;
  RideListModel? _rideHistoryModel;

  EntityDojahModel? get entityDojahModel => _entityDojahModel;
  EntityDojahModel? _entityDojahModel;

  UserDetailsModel? get userDetailModel => _userDetailsModel;
  UserDetailsModel? _userDetailsModel;
  UserLocationModel? get userLocationModel => _userLocationModel;
  UserLocationModel? _userLocationModel;

  ServiceIdModel? get serviceIdModel => _serviceIdModel;
  ServiceIdModel? _serviceIdModel;

  ServicesModel? get servicesModel => _servicesModel;
  ServicesModel? _servicesModel;
  ServicesProviderPlans? get serviceProviderPlans => _serviceProviderPlans;
  ServicesProviderPlans? _serviceProviderPlans;

  UpcomingRequest? get upcomingRequest => _upcomingRequest;
  UpcomingRequest? _upcomingRequest;

  TotalRequestModel? get totalRequestModel => _totalRequestModel;
  TotalRequestModel? _totalRequestModel;

  CompletedRequestModel? get completedRequestModel => _completedRequestModel;
  CompletedRequestModel? _completedRequestModel;
  CancelledRequestModel? get cancelledRequestModel => _cancelledRequestModel;
  CancelledRequestModel? _cancelledRequestModel;

  AcceptRejectBookingModel? get acceptRejectBookingModel =>
      _acceptRejectBookingModel;
  AcceptRejectBookingModel? _acceptRejectBookingModel;

  bool get isAvailable =>
      _upcomingRequest != null &&
      _upcomingRequest?.data != null &&
      _upcomingRequest!.data!.isNotEmpty;

  bool get isPresent =>
      _serviceProviderPlans != null &&
      _serviceProviderPlans?.data != null &&
      _serviceProviderPlans!.data!.isNotEmpty;

  void signIn({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;

      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      notifyListeners();
      Response? response = await authRepo.login(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        _loginModel = LoginModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_loginModel?.message}'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));
        print(_loginModel?.data?.apiToken);
        SessionManager.instance.authToken = _loginModel!.data!.apiToken!;
        Navigator.of(context!).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => NavBarPage()));
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_registerModel?.message}'),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () {},
        ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void register({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.register(map!);
      if (response != null && response.statusCode == 200) {
        _registerModel = RegisterModel.fromJson(response.data);
        print(_registerModel!.data!.userDetails!.email!);
        print(_registerModel!.data!.userDetails!.mobile!);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_registerModel?.message}'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));
        print(_registerModel!.data!.userDetails!.email!);
        SessionManager.instance.authToken =
            _registerModel!.data!.userDetails!.apiToken!;
        _isLoading = false;
        sendOTP(context);
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => OtpVerification(),
          ),
        );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_registerModel?.message}'),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () {},
        ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  // logout remove token and navigate to login screen
  void logout(BuildContext context) async {
    changeOnlineStatus(context: context);

    SessionManager.instance.logOut();
    notifyListeners();

    Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (context) => const SignWithEmailWidget(),
      ),
    );
  }

  void sendOTP(context) async {
    try {
      _isLoading = true;
      notifyListeners();
      print('${_registerModel?.data?.userDetails!.mobile}');

      print('${_registerModel?.data?.userDetails!.email}');

      phoneNumber = _registerModel?.data?.userDetails!.mobile ?? '';
      Response? response =
          await authRepo.sendOtp({'phone_number': phoneNumber!});
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // Navigator.of(context!).pop();
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => OtpVerification(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void LocationOTP(context) async {
    try {
      _isLoading = true;
      notifyListeners();
      // print('${_registerModel?.data?.userDetails!.mobile}');
      //
      // print('${_registerModel?.data?.userDetails!.email}');
      //
      // phoneNumber = _registerModel?.data?.userDetails!.mobile ?? '';

      Response? response = await authRepo.sendLocation({
        "location": "Oneal Center Jabi",
        "location_lat": "9.0787",
        "location_long": "7.47018",
        "state": "Abuja"
      });

      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // Navigator.of(context!).pop();
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => OtpVerification(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendPasswordChange(
      {required context, required String phoneNumber}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response =
          await authRepo.sendPasswordChange({'phone_number': phoneNumber!});
      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ChangePassScreen(userPhone: phoneNumber)));

        _isLoading = false;

        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => ChangePassScreen(
        //       userPhone: phoneNumber,
        //     ),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Please make sure to register first'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  // changeOnlineStatus
  void changeOnlineStatus({BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.changeOnlineStatus();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        getUserDetails();
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void changePassword({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.changePassword(map!);
      if (response != null && response.statusCode == 200) {
        // _registerModel = RegisterModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => SignWithEmailWidget()));

        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const LoginScreen(),
        //   ),
        // );
        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void changeCredentials(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.ChangeCredentials(map!);
      if (response != null && response.statusCode == 200) {
        // _registerModel = RegisterModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void verifyOTP({context, otpNumber}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo
          .verifyOtp({"phone_number": phoneNumber!, "otp": otpNumber});
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 5),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        // LocationSet({});

        Response? responses = await authRepo.sendLocation({
          "location": "Oneal Center Jabi",
          "location_lat": "9.0787",
          "location_long": "7.47018",
          "state": "Abuja"
        });

        notifyListeners();
        _isLoading = false;
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => const VehicleDetailsWidget(),
          ),
        );
        notifyListeners();
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Please enter OTP sent to phone'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void deleteAccount({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.deleteAccount(map!);
      if (response != null && response.statusCode == 200) {
        // _registerModel = RegisterModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: AutoSizeText('Account Deleted Successfully,'
              ' we are sorry to see you go , but you can signup to continue using our services'),
          duration: Duration(seconds: 10),
        ));
        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: AutoSizeText('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: AutoSizeText('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void updateProfile({context, Map<String, dynamic>? credentials}) async {
    try {
      _isLoading = true;
      notifyListeners();
      var response = await authRepo.updateProfile(credentials!);
      if (response?.entries.first.toString() == 1) {
        _isLoading = false;

        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('image is too large, pls pick another one'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceProviderHomeScreen(),
        //   ),
        // );
      }

      if (response?.entries.first.toString() != 1) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('upload successful'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void onboardRider({context, Map<String, dynamic>? credentials}) async {
    try {
      _isLoading = true;
      notifyListeners();
      var response = await authRepo.onboardRider(credentials!);
      if (response?.entries.first.toString() == 1) {
        _isLoading = false;

        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('image is too large, pls pick another one'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        LocationOTP(context);
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceProviderHomeScreen(),
        //   ),
        // );
      }

      if (response?.entries.first.toString() != 1) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('upload successful'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void services() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.services();
      if (response != null && response.statusCode == 200) {
        _servicesModel = ServicesModel.fromJson(response.data);
        _isLoading = false;
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void serviceHome() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.serviceHome();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();

        _serviceHhomeModel = ServiceHomeModel.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getBankDetails(context) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.getBankDetails();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // LocationOTP(context);
        _bankDetail = BankDetail.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getWithdrawHistory(context) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.walletHistory();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // LocationOTP(context);
        _withdrawHistoryModel = WithdrawHistoryModel.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getRideHistory(context, int status) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.rideHistory(status);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // LocationOTP(context);
        _rideHistoryModel = RideListModel.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getBankList(context) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.bankList();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        LocationOTP(context);

        _bankList = BankList.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void addBankDetails({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.addBankDetails(map!);
      if (response != null && response.statusCode == 200) {
        _bankDetail = BankDetail.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (cxt) => ManageBankPageWidget()));
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void updateRequest({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.updateOrder(map!);
      if (response != null && response.statusCode == 200) {
        _bankModel = BankModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getWalletHistory(context) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.walletHistory();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        _walletModel = WalletModel.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void withdrawMoney({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.makeWithdrawal(map!);
      if (response != null && response.statusCode == 200) {
        _walletModel = WalletModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please add bank account or make sure'
              ' you have enough money in your wallet up to 5000'),
          duration: const Duration(seconds: 10),
        ));

        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => ManageBankPageWidget()));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendSmsUser({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.sendUserSms(map!);
      if (response != null && response.statusCode == 200) {
        // _walletModel = WalletModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(
                'Pin sent to user successfully, please get pin to complete order'),
            duration: const Duration(seconds: 5),
          ),
        );

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('FAiled to send pin'),
          duration: const Duration(seconds: 10),
        ));

        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => ManageBankPageWidget()));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void validateSmsUser(
      {Map<String, String>? map,
      BuildContext? context,
      String? orderId}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.validateOrder(map!);
      if (response != null && response.statusCode == 200) {
        // _walletModel = WalletModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Pin verified successfully, please kindly rate us'),
          duration: const Duration(seconds: 10),
        ));

        upcomingRequests();
        completedRequests();
        canceledRequests();

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FeedBackScreen(bookingId: orderId!)),
        );

        _isLoading = false;
        _isSuccessful = true;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Failed to verify Pin'),
          duration: const Duration(seconds: 10),
        ));

        // Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
        //     ManageBankPageWidget()));

        _isLoading = false;
        _isSuccessful = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      _isSuccessful = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void updateOrder({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.updateOrder(map!);
      if (response != null && response.statusCode == 200) {
        _walletModel = WalletModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void validateBank({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.validateBankDetails(map!);
      if (response != null && response.statusCode == 200) {
        _bankModel = BankModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
        // sendOTP(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${response?.statusMessage}'),
          duration: const Duration(seconds: 10),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      var response;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${response?.statusMessage}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void serviceproviderplans() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.providerPlans();
      if (response != null && response.statusCode == 200) {
        _serviceProviderPlans = ServicesProviderPlans.fromJson(response.data);
        _isLoading = false;
      }

      if (response != null && response.statusCode != 200) {
        SessionManager.instance.logOut();
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void upcomingRequests() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.upcomingRequest();
      if (response != null && response.statusCode == 200) {
        _upcomingRequest = UpcomingRequest.fromJson(response.data);
        _isLoading = false;
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void canceledRequests() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.canceledRequest();
      if (response != null && response.statusCode == 200) {
        _cancelledRequestModel = CancelledRequestModel.fromJson(response.data);
        _isLoading = false;
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void completedRequests() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.CompletedRequest();
      if (response != null && response.statusCode == 200) {
        _completedRequestModel = CompletedRequestModel.fromJson(response.data);
        _isLoading = false;
      }
      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void totalRequests() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.totalRequests();
      if (response != null && response.statusCode == 200) {
        _totalRequestModel = TotalRequestModel.fromJson(response.data);
        _isLoading = false;
      }
      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void acceptRejectBooking(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.acceptRejectBooking(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        _acceptRejectBookingModel =
            AcceptRejectBookingModel.fromJson(response.data);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_acceptRejectBookingModel?.message}'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_acceptRejectBookingModel?.message}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void acceptBooking({
    Map<String, String>? map,
    BuildContext? context,
    String? bookingId,
    String? vendorAddress,
    String? userAddress,
    String? userMobile,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.acceptOrder(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        _isSuccessful = true;
        SessionManager.instance.isLoggedIn = true;

        _acceptRejectBookingModel =
            AcceptRejectBookingModel.fromJson(response.data);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_acceptRejectBookingModel?.message}'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => TripPageVendor(
                    bookingId: bookingId.toString().toString(),
                    vendorAddress: vendorAddress!,
                    userAddress: userAddress!,
                    userMobile: userMobile ?? '',
                    date: '12/23/12')));

        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
        _isSuccessful = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      _isSuccessful = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_acceptRejectBookingModel?.message}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void completeBookingN(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.completeBookingN(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        _isSuccessful = true;
        SessionManager.instance.isLoggedIn = true;

        _acceptRejectBookingModel =
            AcceptRejectBookingModel.fromJson(response.data);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_acceptRejectBookingModel?.message}'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
        _isSuccessful = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      _isSuccessful = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_acceptRejectBookingModel?.message}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void rejectBooking({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.rejectOrder(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        _isSuccessful = true;
        SessionManager.instance.isLoggedIn = true;

        _acceptRejectBookingModel =
            AcceptRejectBookingModel.fromJson(response.data);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('${_acceptRejectBookingModel?.message}'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () {},
          // ),
        ));

        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
        _isSuccessful = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      _isSuccessful = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_acceptRejectBookingModel?.message}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void updateBooking({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.updateOrder(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        _isSuccessful = true;
        SessionManager.instance.isLoggedIn = true;

        _acceptRejectBookingModel =
            AcceptRejectBookingModel.fromJson(response.data);

        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        //   content: Text('${_acceptRejectBookingModel?.message}'),
        //   duration: const Duration(seconds: 10),
        //   action: SnackBarAction(
        //     label: 'ACTION',
        //     onPressed: () {},
        //   ),
        // ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isSuccessful = false;
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      _isSuccessful = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('${_acceptRejectBookingModel?.message}'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void endBooking(
      {Map<String, String>? map,
      BuildContext? context,
      String? bookingId}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.endBooking(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        // _completedRequestModel = CompletedRequestModel.fromJson(response.data);
        //
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('booking completed successfully'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FeedBackScreen(bookingId: bookingId.toString())),
        );
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void goOffline({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.goOffline(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        // _completedRequestModel = CompletedRequestModel.fromJson(response.data);
        //
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Offline status'),
          duration: Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void goOnline({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.goOnline(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        // _completedRequestModel = CompletedRequestModel.fromJson(response.data);
        //
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Online Status updated successfully'),
          duration: Duration(seconds: 10),
        ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void verifyUser({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.verifyUser(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Verified successfully'),
          duration: Duration(seconds: 10),
        ));

        Navigator.pop(context);
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('We could not verify your number'),
          duration: Duration(seconds: 5),
        ));

        _isLoading = false;

        showAlertDialog(context);
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void verifyWithBvn({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.verifyWithBvn(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Verified successfully'),
          duration: Duration(seconds: 10),
        ));
        Navigator.of(context).popUntil(ModalRoute.withName("/profileScreen"));
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('We could not verify your number'),
          duration: Duration(seconds: 5),
        ));

        _isLoading = false;

        showAlertDialog(context);
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void verifyBvnNumber(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.verifyBvnNumber(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Verified successfully'),
          duration: Duration(seconds: 10),
        ));

        Navigator.of(context).popUntil(ModalRoute.withName("/profileScreen"));
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('We could not verify your number'),
          duration: Duration(seconds: 5),
        ));

        _isLoading = false;

        // showAlertDialog(context);
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void verifyUler({context, Map<String, dynamic>? credentials}) async {
    try {
      _isLoading = true;
      notifyListeners();
      var response = await authLepo.verifyUler(credentials!);
      if (response != null) {
        _isLoading = false;

        // ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
        //   content:  Text('profile updated successfully'),
        //   duration: Duration(seconds: 10),
        //   // action: SnackBarAction(
        //   //   label: 'ACTION',
        //   //   onPressed: () { },
        //   // ),
        // ));
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceProviderHomeScreen(),
        //   ),
        // );
      }

      if (response != null) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendSupportMessage(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.sendSupportMessage(map!);
      if (response != null && response.statusCode == 200) {
        // _userLocationModel = UserLocationModel.fromJson(response.data);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('message sent successfully'),
          duration: const Duration(seconds: 5),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please make sure to enter email, support and message'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void rateCustomer({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.rateCustomer(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        // _completedRequestModel = CompletedRequestModel.fromJson(response.data);
        //
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('$response'),
          duration: const Duration(seconds: 10),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () { },
          // ),
        ));
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('$e'),
        duration: const Duration(seconds: 10),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void serviceId(String num) async {
    try {
      _isLoading = true;
      Response? response = await authRepo.serviceId(num);
      if (response != null && response.statusCode == 200) {
        _serviceIdModel = ServiceIdModel.fromJson(response.data);
        _isLoading = false;
      }
      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getUserDetails() async {
    try {
      _isLoading = true;
      Response? response = await authRepo.getUserDetails();
      if (response != null && response.statusCode == 200) {
        _isLoading = false;

        _userDetailsModel = UserDetailsModel.fromJson(response.data);
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendLocation({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.LocationSet(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        // _servicesModel = ServicesModel.fromJson(response.data);
        SessionManager.instance.authToken =
            _registerModel!.data!.userDetails!.apiToken!;
        // Navigator.pushAndRemoveUntil(
        //     context!,
        //     MaterialPageRoute(
        //         builder: (context) => ServiceProviderHomeScreen(),
        //         maintainState: true),
        //     (Route<dynamic> route) => false);
      }

      if (response != null && response.statusCode != 200) {
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        //   content: Text('Please make sure to enter the correct location'),
        //   duration: const Duration(seconds: 10),
        //   action: SnackBarAction(
        //     label: 'ACTION',
        //     onPressed: () {},
        //   ),
        // ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendVerify({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authLepo.uploadAndVerify(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // SessionManager.instance.isLoggedIn = true;

        _entityDojahModel = EntityDojahModel.fromJson(response.data);

        if (int.parse('${_entityDojahModel?.entity?.selfie?.confidenceValue}') >
            70) {
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content:
                Text('${_entityDojahModel?.entity?.selfie?.confidenceValue}'),
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              label: 'ACTION',
              onPressed: () {},
            ),
          ));
        } else {
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: const Text('we cannot verify your identity'),
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              label: 'ACTION',
              onPressed: () {},
            ),
          ));
        }

        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceProviderHomeScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please make sure to enter the correct location'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendNinVerify({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authLepo.uploadAndVerifyNin(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        _servicesModel = ServicesModel.fromJson(response.data);
        Navigator.of(context!).pop();

        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceProviderHomeScreen(),
        //   ),
        // );
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please make sure to enter the correct location'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendLocationAlternate(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.sendLocation(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        // SessionManager.instance.isLoggedIn = true;

        _userLocationModel = UserLocationModel.fromJson(response.data);

        Navigator.of(context!).pop();
        // Navigator.push(
        //     context!,
        //     MaterialPageRoute(
        //         builder: (context) => const ServiceProviderHomeScreen()
        //     ));
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please make sure to enter the correct location'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getLocation({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.userLocation();
      if (response != null && response.statusCode == 200) {
        _userLocationModel = UserLocationModel.fromJson(response.data);
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        //   content:  Text('${_userLocationModel?.message}'),
        //   duration: const Duration(seconds: 10),
        //   action: SnackBarAction(
        //     label: 'ACTION',
        //     onPressed: () { },
        //   ),
        // ));
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;
      }

      if (response != null && response.statusCode != 200) {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text('Please make sure to enter the correct location'),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'ACTION',
            onPressed: () {},
          ),
        ));

        _isLoading = false;
      }
      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const IdVerificationHomeScreen(),
        //   ),
        // );

        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Verification"),
      content: Text(
          "Unfornately we couldn't verify you, would you like use another method of verification?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void sendServiceId({Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.sendServiceId(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;
        SessionManager.instance.isLoggedIn = true;

        _servicesModel = ServicesModel.fromJson(response.data);
        SessionManager.instance.authToken =
            _registerModel!.data!.userDetails!.apiToken!;
        // Navigator.pop(context!);
        // Navigator.push(
        //   context!,
        //   MaterialPageRoute(
        //     builder: (context) => const ServiceLocationScreen(),
        //   ),
        // );
        SessionManager.instance.isLoggedIn = true;
        SessionManager.instance.authToken =
            _registerModel!.data!.userDetails!.apiToken!;
      }

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void sendServiceIdFull(
      {Map<String, String>? map, BuildContext? context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Response? response = await authRepo.sendServiceId(map!);
      if (response != null && response.statusCode == 200) {
        _isLoading = false;

        _servicesModel = ServicesModel.fromJson(response.data);
        Navigator.pop(context!);
      }

      notifyListeners();

      if (response != null && response.statusCode != 200) {
        _isLoading = false;
      }

      notifyListeners();
    } catch (e, str) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      return false;
    }
    return true;
  }
}
