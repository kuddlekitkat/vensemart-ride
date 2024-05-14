import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:vensemart_delivery/provider/provider_services.dart';
import 'package:vensemart_delivery/backend/model/upcoming_request.dart';


import 'feedback_screen.dart';

class AcceptRejectBookingsScreen extends StatefulWidget {
  String bookingId;
  String userAddress;
  String vendorAddress;
  String userMobile;
  String date;
  Data? rideData;

  AcceptRejectBookingsScreen(
      {required this.bookingId,
      required this.userAddress,
      required this.userMobile,
      required this.vendorAddress,
      required this.date,
      this.rideData});

  // const AcceptRejectBookingsScreen();

  @override
  State<AcceptRejectBookingsScreen> createState() =>
      _AcceptRejectBookingsScreenState();
}

class _AcceptRejectBookingsScreenState
    extends State<AcceptRejectBookingsScreen> {
  ProviderServices? providerServices;

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    super.initState();
  }

  void acceptBooking(context) async {
    if (true) {
      providerServices?.acceptRejectBooking(
        map: {
          "booking_id": widget.bookingId.toString(),
          "status": 1.toString(),
        },
        context: context,
      );

      MapsLauncher.launchQuery(widget.userAddress);
    }
  }

  void tripBooking(context) async {
    if (true) {
      providerServices?.acceptBooking(
        map: {
          "order_id": widget.bookingId.toString(),
        },
        context: context,
        bookingId: widget.bookingId,
        userAddress: widget.userAddress,
        vendorAddress: widget.vendorAddress,
        userMobile: widget.userMobile,
      );
    }
  }

  void rejectBooking(context) async {
    if (true) {
      providerServices?.rejectBooking(map: {
        "order_id": widget.bookingId.toString(),
        // "status" : "4"
      }, context: context);
    }
  }

  void endBooking(context) async {
    if (true) {
      providerServices?.endBooking(map: {
        "booking_id": widget.bookingId.toString(),
        "status": 3.toString()
      }, context: context, bookingId: widget.bookingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 3),
      appBar: AppBar(
        backgroundColor: const Color(0xff1456f1),
        title: const Text("Request Screen"),
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
              height: MediaQuery.of(context).size.height / 1.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(' New Request',
                      style: TextStyle(
                          fontSize:
                              2.0 * MediaQuery.of(context).size.height * 0.01,
                          fontWeight: FontWeight.bold)),
                  // SizedBox(height: 12,),
                  Text(
                    'Pickup Location : ${widget.vendorAddress}',
                    style: TextStyle(
                        fontSize:
                            2.0 * MediaQuery.of(context).size.height * 0.01,
                        fontWeight: FontWeight.w400),
                  ),

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
                            '${widget?.userMobile}');
                      },
                      child: Text(
                        '${widget?.userMobile}',
                        style: TextStyle(
                            fontSize:
                                2.0 * MediaQuery.of(context).size.height * 0.01,
                            fontWeight: FontWeight.w400),
                      )),
                  widget.rideData != null
                      ? Column(children: [
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
                        ])
                      : Container(),
                  // AutoSizeText('Date : ${widget.date}',
                  //     style: TextStyle(
                  //         fontSize:
                  //             2.0 * MediaQuery.of(context).size.height * 0.01,
                  //         fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(
              height: 45.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => tripBooking(context),
                    child: Consumer<ProviderServices>(
                      builder: (_, value2, __) => Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 14,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          child: value2.isLoading == true
                              ? const SpinKitCircle(
                                  color: Colors.white,
                                )
                              : Center(
                                  child: Text(
                                    'Accept',
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
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => rejectBooking(context),
                    child: Consumer<ProviderServices>(
                      builder: (_, value1, __) => Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 14,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          child: value1.isLoading == true
                              ? const SpinKitCircle(
                                  color: Colors.white,
                                )
                              : Center(
                                  child: Text(
                                    'Reject',
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
            // Container(
            //   padding: const EdgeInsets.only(left: 12, top: 20),
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height / 9,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12.0)),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       // AutoSizeText('New Request',style: TextStyle(
            //       //    //ios : 1.5
            //       // fontSize: 2.0 *
            //       // MediaQuery.of(context).size.height *
            //       // 0.01, fontWeight: FontWeight.bold)),
            //       Text(
            //         'You will be redirected to google maps with the address once you accept ',
            //         style: TextStyle(
            //             fontSize:
            //             1.5 * MediaQuery.of(context).size.height * 0.01,
            //             fontWeight: FontWeight.w300),
            //       ),
            //
            //       // AutoSizeText('29 October 2022',style: TextStyle( //ios : 1.5
            //       // fontSize: 2.0 *
            //       // MediaQuery.of(context).size.height *
            //       // 0.01, fontWeight: FontWeight.w400)),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 40.0,
            ),
            // GestureDetector(
            //   onTap: () => endBooking(context),
            //   child: Consumer<ProviderServices>(
            //     builder: (_, value1, __) => Center(
            //       child: Container(
            //         height: MediaQuery.of(context).size.height / 14,
            //         width: MediaQuery.of(context).size.width / 1.5,
            //         decoration: BoxDecoration(
            //           color: const Color(0xff1456f1),
            //           borderRadius: BorderRadius.circular(90.0),
            //         ),
            //         child: value1.isLoading == true
            //             ? const SpinKitCircle(
            //           color: Colors.white,
            //         )
            //             : Center(
            //           child: Text(
            //             'Job Done',
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
          ],
        ),
      ),
    );
  }
}
