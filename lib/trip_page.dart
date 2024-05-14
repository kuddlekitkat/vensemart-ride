import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:vensemart_delivery/backend/model/upcoming_request.dart';
import 'package:vensemart_delivery/provider/provider_services.dart';
import 'package:vensemart_delivery/verify_order_otp.dart';

import 'feedback_screen.dart';

class TripPage extends StatefulWidget {
  String bookingId;
  String userAddress;
  String userMobile;
  String vendorAddress;
  String date;
  Data? rideData;

  TripPage(
      {required this.bookingId,
      required this.userAddress,
      required this.userMobile,
      required this.vendorAddress,
      this.rideData,
      required this.date});

  // const TripPage();

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  ProviderServices? providerServices;

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    super.initState();
  }

  void sendUserSms(context) async {
    setState(() {});
    providerServices?.sendSmsUser(map: {
      "order_id": widget.bookingId.toString(),
      "phone": widget.userMobile.toString(),
    }, context: context);
  }

  void acceptBooking(context) async {
    if (true) {
      sendUserSms(context);
      // providerServices?.acceptRejectBooking(map: {
      //   "booking_id": widget.bookingId.toString(),
      //   "status": 1.toString()
      // }, context: context);
      // providerServices?.updateBooking(map: {
      //   "order_id": widget.bookingId.toString(),
      //   "status": 3.toString(),
      // }, context: context);

      MapsLauncher.launchQuery(widget.userAddress);
    }
  }

  void rejectBooking(context) async {
    if (true) {
      // providerServices?.acceptRejectBooking(map: {
      //   "booking_id": widget.bookingId.toString(),
      //   "status": 2.toString()
      // }, context: context);

      MapsLauncher.launchQuery(widget.userAddress);
    }
  }

  // void checkUserSms(context) async {
  //   setState(() {});
  //   providerServices?.withdrawMoney(map: {
  //     "amount": "${textController?.text}",
  //   }, context: context);
  //
  // }

  void endBooking(context) async {
    if (true) {
      providerServices?.updateBooking(map: {
        "order_id": widget.bookingId.toString(),
        "status": 4.toString(),
      }, context: context);

      if (providerServices?.isSuccessful == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerifyOrderOtp(order_id: widget.bookingId.toString())),
        );
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: AutoSizeText('Something went wrong, please try again later'),
          duration: const Duration(seconds: 5),
          // action: SnackBarAction(
          //   label: 'ACTION',
          //   onPressed: () {},
          // ),
        ));
      }

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           FeedBackScreen(bookingId: widget.bookingId.toString())),
      // );
    }
  }

  void completeBooking(context) async {
    if (true) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: VerifyOrderOtp(
                order_id: widget.bookingId.toString(),
              ),
            );
          });
      // providerServices?.completeBookingN(map: {
      //   "order_id": widget.bookingId.toString(),
      // }, context: context);

      // ScaffoldMessenger.of(context).removeCurrentSnackBar();

      // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      //   content: AutoSizeText('User Trip Completed Successfully, '
      //       'please kindly rate us'),
      //   duration: const Duration(seconds: 5),
      //   // action: SnackBarAction(
      //   //   label: 'ACTION',
      //   //   onPressed: () {},
      //   // ),
      // ));

      // // delay for 5 seconds
      // await Future.delayed(const Duration(seconds: 5));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           VerifyOrderOtp(order_id: widget.bookingId.toString())),
      // );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           FeedBackScreen(bookingId: widget.bookingId.toString())),
      // );
    }
  }
  // void completeBooking(context) async {
  //   if (true) {
  //     providerServices?.completeBookingN(map: {
  //       "order_id": widget.bookingId.toString(),
  //     }, context: context);

  //     ScaffoldMessenger.of(context).removeCurrentSnackBar();

  //     ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
  //       content: AutoSizeText('User Trip Completed Successfully, '
  //           'please kindly rate us'),
  //       duration: const Duration(seconds: 5),
  //       // action: SnackBarAction(
  //       //   label: 'ACTION',
  //       //   onPressed: () {},
  //       // ),
  //     ));

  //     // delay for 5 seconds
  //     await Future.delayed(const Duration(seconds: 5));

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               VerifyOrderOtp(order_id: widget.bookingId.toString())),
  //     );

  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //       builder: (context) =>
  //     //           FeedBackScreen(bookingId: widget.bookingId.toString())),
  //     // );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 3),
      appBar: AppBar(
        backgroundColor: const Color(0xff1456f1),
        title: const Text("User Trip"),
        leading: IconButton(
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText('User Trip',
                      style: TextStyle(
                          fontSize:
                              2.0 * MediaQuery.of(context).size.height * 0.01,
                          fontWeight: FontWeight.bold)),
                  // SizedBox(height: 12,),
                  // Text(
                  //   'Pickup Location : ${widget.vendorAddress}',
                  //   style: TextStyle(
                  //       fontSize:
                  //       2.0 * MediaQuery.of(context).size.height * 0.01,
                  //       fontWeight: FontWeight.w400),
                  // ),

                  // SizedBox(height: 12,),

                  Text(
                    'Destination : ${widget.userAddress}',
                    style: TextStyle(
                        fontSize:
                            2.0 * MediaQuery.of(context).size.height * 0.01,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber(
                          '${widget.userMobile}');
                    },
                    child: Text(
                      '${widget?.userMobile}',
                      style: TextStyle(
                          fontSize:
                              2.0 * MediaQuery.of(context).size.height * 0.01,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  if (widget.rideData != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ride Type : ${widget.rideData!.rideType}',
                          style: TextStyle(
                              fontSize: 2.0 *
                                  MediaQuery.of(context).size.height *
                                  0.01,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Item Type : ${widget.rideData!.itemType}',
                          style: TextStyle(
                              fontSize: 2.0 *
                                  MediaQuery.of(context).size.height *
                                  0.01,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Product Categories : ${widget.rideData!.itemCategories}',
                          style: TextStyle(
                              fontSize: 2.0 *
                                  MediaQuery.of(context).size.height *
                                  0.01,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Other Users Name : ${widget.rideData!.otherRiderName ?? "No other user name"}',
                          style: TextStyle(
                              fontSize: 2.0 *
                                  MediaQuery.of(context).size.height *
                                  0.01,
                              fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {
                            // FlutterPhoneDirectCaller.callNumber(
                            //     '${widget.userMobile}');
                            if (widget.rideData!.otherRiderPhoneNumber !=
                                null) {
                              FlutterPhoneDirectCaller.callNumber(
                                  '${widget.rideData!.otherRiderPhoneNumber}');
                            }
                          },
                          child: Text(
                            'Other Users Phone : ${widget.rideData!.otherRiderPhoneNumber ?? "No other user phone"}',
                            style: TextStyle(
                                fontSize: 2.0 *
                                    MediaQuery.of(context).size.height *
                                    0.01,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),

                  AutoSizeText('Date : ${widget.date}',
                      style: TextStyle(
                          fontSize:
                              2.0 * MediaQuery.of(context).size.height * 0.01,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () => acceptBooking(context),
                  //   child: Consumer<ProviderServices>(
                  //     builder: (_, value2, __) => Center(
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height / 15,
                  //         width: MediaQuery.of(context).size.width / 2.7,
                  //         decoration: BoxDecoration(
                  //           color: Colors.green,
                  //           borderRadius: BorderRadius.circular(90.0),
                  //         ),
                  //         child: value2.isLoading == true
                  //             ? const SpinKitCircle(
                  //           color: Colors.white,
                  //         )
                  //             : Center(
                  //           child: Text(
                  //             'Pickup',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 //ios : 1.5
                  //                 fontSize: 2.0 *
                  //                     MediaQuery.of(context).size.height *
                  //                     0.01,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  GestureDetector(
                    onTap: () => rejectBooking(context),
                    child: Consumer<ProviderServices>(
                      builder: (_, value1, __) => Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width / 1.4,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          child: value1.isLoading == true
                              ? const SpinKitCircle(
                                  color: Colors.white,
                                )
                              : Center(
                                  child: Text(
                                    'Start User Trip',
                                    style: TextStyle(
                                        color: Colors.white,
                                        //ios : 1.5
                                        fontSize: 2.0 *
                                            MediaQuery.of(context).size.height *
                                            0.01,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // AutoSizeText('New Request',style: TextStyle(
                  //    //ios : 1.5
                  // fontSize: 2.0 *
                  // MediaQuery.of(context).size.height *
                  // 0.01, fontWeight: FontWeight.bold)),
                  Text(
                    'You will be redirected to google maps with user\'s address ',
                    style: TextStyle(
                        fontSize:
                            2.5 * MediaQuery.of(context).size.height * 0.01,
                        fontWeight: FontWeight.w300),
                  ),

                  // AutoSizeText('29 October 2022',style: TextStyle( //ios : 1.5
                  // fontSize: 2.0 *
                  // MediaQuery.of(context).size.height *
                  // 0.01, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () => completeBooking(context),
              child: Consumer<ProviderServices>(
                builder: (_, value1, __) => Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      color: const Color(0xff1456f1),
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    child: value1.isLoading == true
                        ? const SpinKitCircle(
                            color: Colors.white,
                          )
                        : Center(
                            child: Text(
                              'End Trip',
                              style: TextStyle(
                                  color: Colors.white,
                                  //ios : 1.5
                                  fontSize: 2.0 *
                                      MediaQuery.of(context).size.height *
                                      0.01,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
