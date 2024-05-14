import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/backend/apiservices/validator.dart';

import '../backend/model/general_model.dart';
import '../provider/provider_services.dart';
import '../sign_with_email/sign_with_email_widget.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import '../terms_conditions.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;

  ProviderServices? providerServices;
  final _globalFormKey = GlobalKey<FormState>();
  bool isChecked = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;

  late bool _passwordVisible;

  var deviceInfo;
  String? device = '';

  late bool passwordVisibility;
  bool? checkboxValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    _passwordVisible = false;
    deviceInfo = DeviceInfoPlugin();
    initOneSignal(context);
    deviceToken = OneSignal.User.pushSubscription.id;

    // try and print deviceInfo to see all required stuffs then get the device name and pass it to the registration function
    _getId();
  }

  // bool _requireConsent = true;

  Future<void> initOneSignal(BuildContext context) async {
    deviceToken = OneSignal.User.pushSubscription.id;

    /// Set App Id.
    // await OneSignal.shared.setAppId("e5db6fdd-df18-49a3-b1c7-c2c27645e144");

    // /// Get the Onesignal userId and update that into the firebase.
    // /// So, that it can be used to send Notifications to users later.̥
    // final status = await OneSignal.shared.getDeviceState();
    // final String? osUserID = status?.userId;
    // deviceToken = osUserID;
    // print(deviceToken);
    // // We will update this once he logged in and goes to dashboard.
    // ////updateUserProfile(osUserID);
    // // Store it into shared prefs, So that later we can use it.
    // // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // await OneSignal.shared.promptUserForPushNotificationPermission(
    //   fallbackToSettings: true,
    // );
  }

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

  void signUp(context) async {
    if (_globalFormKey.currentState!.validate() && isChecked == true) {
      phoneNumber = phoneNumberController.text.trim();
      setState(() {});
      providerServices?.register(map: {
        "type": "2",
        "device_id": device!,
        "device_type": Platform.isIOS ? "iPhone" : "android",
        "device_name": deviceInfo.toString(),
        "device_token": "$deviceToken",
        "name": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "mobile": phoneNumberController.text.trim(),
        "password": passwordController.text.trim(),
        "state": "FCT",
        "town": "Abuja"
      }, context: context);
    }
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color(0xff1456f1);
      }
      return Colors.grey;
    }

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
                  'Signup',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11.5,
                        child: Container(
                          margin: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            validator: Validators.validateString(),
                            controller: usernameController,
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
                                hintText: 'Full Name',
                                prefixIcon: const Icon(Icons.person_rounded),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                fillColor:
                                    const Color.fromRGBO(250, 250, 254, 1)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11.5,
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11.5,
                        child: Container(
                          margin: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            validator: Validators.validatePhone(),
                            controller: phoneNumberController,
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
                                hintText: '08107463265',
                                prefixIcon: Container(
                                  height: 20,
                                  width: 25,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(234, 234, 234, 3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0))),
                                  child: Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/flag.png'))),
                                    ),
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                fillColor:
                                    const Color.fromRGBO(250, 250, 254, 1)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11.5,
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
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                fillColor:
                                    const Color.fromRGBO(250, 250, 254, 1)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 26.5,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  print(isChecked);
                                });
                              },
                            ),
                            const Text(
                              'By checking the box,agree to our ',
                              style: TextStyle(fontSize: 10),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context!,
                                  MaterialPageRoute(
                                    builder: (context) => TermsScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'terms and conditions',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () => signUp(context),
                        child: Consumer<ProviderServices>(
                          builder: (_, value, __) => Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 14.5,
                              width: MediaQuery.of(context).size.width / 1.10,
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
                                        'Register',
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
                      SizedBox(
                        height: 8,
                      ),
                      // const SizedBox(
                      //   height: 10.0,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SignWithEmailWidget(),
                                ),
                              );
                            },
                            child: const Text(
                              ' sign in',
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
              ),
            ],
          ),
        ));
  }
}
