import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/backend/apiservices/validator.dart';
import 'package:vensemart_delivery/forget_password.dart';

import '../provider/provider_services.dart';
import '../signup/signup_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SignWithEmailWidget extends StatefulWidget {
  const SignWithEmailWidget({Key? key}) : super(key: key);

  @override
  _SignWithEmailWidgetState createState() => _SignWithEmailWidgetState();
}

class _SignWithEmailWidgetState extends State<SignWithEmailWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _currentAddress;
  Position? _currentPosition;

  ProviderServices? providerServices;
  final _globalFormKey = GlobalKey<FormState>();

  Future<void> _getCurrentPosition() async {
    final hasPermission = await providerServices?.handleLocationPermission();
    if (hasPermission == true) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } else {
      print('Permission denied');
      await providerServices?.handleLocationPermission();
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;
  var deviceInfo;
  String? device = '';
  late bool _passwordVisible;

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      device = iosDeviceInfo.identifierForVendor;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      device = androidDeviceInfo.id;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return device;
  }

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    print('${providerServices?.userDetailModel?.data?.name}');

    _passwordVisible = false;
    passwordVisibility = false;
    // _firebaseMessaging.getToken().then((token) {
    //   deviceToken = token;
    //   print("token is $token");
    // });
    deviceToken = OneSignal.User.pushSubscription.id;
    _getCurrentPosition();

    initOneSignal(context);
    super.initState();
    deviceInfo = DeviceInfoPlugin();
    _getId();
  }

  Future<void> initOneSignal(BuildContext context) async {
    /// Set App Id.
    // // await OneSignal.shared.setAppId("580dc8b3-a23b-4ef4-9ec9-fa1fd78c83bb");
    deviceToken = OneSignal.User.pushSubscription.id;

    // await OneSignal.shared.promptUserForPushNotificationPermission(
    //   fallbackToSettings: true,
    // );
  }

  void signIn(context) async {
    _getCurrentPosition();
    if (_globalFormKey.currentState!.validate()) {
      providerServices?.signIn(map: {
        "username": emailController.text,
        "password": passwordController.text,
        "type": "2",
        "device_id": device!,
        "device_type": Platform.isIOS ? "iPhone" : "android",
        "device_name": deviceInfo.toString(),
        "device_token": "$deviceToken",
        "location_lat": _currentPosition?.latitude.toString() ?? '9.0787',
        "location_long": _currentPosition?.longitude.toString() ?? '7.47018',
        "location": _currentAddress.toString() ?? 'Oneal Center Jabi',
        "state": "Abuja",
      }, context: context);
    }
  }

  TextEditingController? textController1;
  TextEditingController? textController2;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xff1456f1),
        body: Form(
          key: _globalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: const Text(
                  'Welcome',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text('Email'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 9,
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: Validators.validateEmail(),
                          controller: emailController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              hintText: 'email',
                              prefixIcon: const Icon(Icons.email_rounded),
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 254, 1)),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text('password'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 9,
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          obscureText: !_passwordVisible,
                          controller: passwordController,
                          validator: Validators.validatePlainPassword(),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              hintText: 'password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              fillColor:
                                  const Color.fromRGBO(250, 250, 254, 1)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 2.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1456f1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => signIn(context),
                      child: Consumer<ProviderServices>(
                        builder: (_, value, __) => Center(
                          child: Container(
                            height: screenHeight / 14.4,
                            width: screenWidth / 1.10,
                            decoration: BoxDecoration(
                              color: const Color(0xff1456f1),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            child: value.isLoading == true
                                ? const SpinKitCircle(
                                    color: Colors.white,
                                  )
                                : const Center(
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 20.0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupWidget(),
                              ),
                            );
                          },
                          child: const Text(
                            'signup',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xff1456f1)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
