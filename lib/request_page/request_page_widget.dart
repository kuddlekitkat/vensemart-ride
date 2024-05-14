import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/accept_reject_booking.dart';
import 'package:vensemart_delivery/widgets/rider_drawer.dart';

import '../about_us/about_us_widget.dart';
import '../contact_u_s/contact_u_s_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../nav_bar_page.dart';
import '../notification_page/notification_page_widget.dart';
import '../preferences/preferences_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../provider/provider_services.dart';
import '../trip_page.dart';
import '../trip_page_vendor.dart';
import '../wallet_page/wallet_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPageWidget extends StatefulWidget {
  const RequestPageWidget({Key? key}) : super(key: key);

  @override
  _RequestPageWidgetState createState() => _RequestPageWidgetState();
}

class _RequestPageWidgetState extends State<RequestPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;
  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getUserDetails();
    providerServices?.totalRequests();
    providerServices?.completedRequests();
    providerServices?.upcomingRequests();
    providerServices?.canceledRequests();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.totalRequestModel?.message == null ||
          provider.upcomingRequest?.message == null ||
          provider.completedRequestModel?.message == null ||
          provider.cancelledRequestModel?.message == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFAFAFA),
        drawer: RiderDrawer(),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: AppBar(
            backgroundColor: Color(0xFFFAFAFA),
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(
                FFIcons.khamburger2,
                color: Color(0xFF363636),
                size: 24,
              ),
            ),
            title: SelectionArea(
                child: Text(
              'Request',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0x83000000),
                    fontSize: 17,
                  ),
            )),
            actions: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_sharp,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
            centerTitle: true,
            elevation: 4,
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor: FlutterFlowTheme.of(context).primaryColor,
                  unselectedLabelColor: Color(0xFF0A2B79),
                  labelStyle: FlutterFlowTheme.of(context).bodyText1,
                  indicatorColor: FlutterFlowTheme.of(context).secondaryColor,
                  tabs: [
                    Tab(
                      text: 'Pending',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Cancelled',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                        child: SingleChildScrollView(
                          child: provider.upcomingRequest!.message == null
                              ? CircularProgressIndicator()
                              : Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ...provider.upcomingRequest!.data!.map((e) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 0, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/Rectangle_43.png',
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SelectionArea(
                                                          child: Text(
                                                        'New booking request',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      )),
                                                      SelectionArea(
                                                          child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                        child: Text(
                                                          // 'Pickup Location: ${e.storeAddress}',
                                                          'Pickup Location: ${e.rideRequestId != null ? e.rideStartAddress : e.storeAddress}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0x81000000),
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      )),

                                                      SelectionArea(
                                                          child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child: Text(
                                                            'Destination: ${e.rideRequestId != null ? e.rideEndAddress : e.deliveryAddress}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0x81000000),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      )),
                                                      // SelectionArea(
                                                      //     child: Text(
                                                      //       'Vendor Mobile: 08101013370',
                                                      //       style: FlutterFlowTheme.of(context)
                                                      //           .bodyText1
                                                      //           .override(
                                                      //         fontFamily: 'Poppins',
                                                      //         color: Color(0xFF7A7C7F),
                                                      //         fontSize: 8,
                                                      //         fontWeight: FontWeight.w600,
                                                      //       ),
                                                      //     )),

                                                      SelectionArea(
                                                          child: Text(
                                                        'User Mobile :  ${e.deliveryMobile}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF7A7C7F),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                e.status == 2.toString() ||
                                                        e.status == 1.toString()
                                                    ? FFButtonWidget(
                                                        onPressed: () async {
                                                          print(
                                                              '${e.deliveryMobile}');

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (ctx) => AcceptRejectBookingsScreen(
                                                                  bookingId: e.id
                                                                      .toString(),
                                                                  userAddress: e.rideRequestId !=
                                                                          null
                                                                      ? e.rideEndAddress
                                                                          .toString()
                                                                      : e.deliveryAddress.toString() ??
                                                                          '',
                                                                  userMobile: e
                                                                          .deliveryMobile
                                                                          .toString() ??
                                                                      '09055949934',
                                                                  vendorAddress: e.rideRequestId !=
                                                                          null
                                                                      ? e.rideStartAddress
                                                                          .toString()
                                                                      : e.storeAddress.toString() ??
                                                                          '',
                                                                          rideData: e.rideRequestId != null ? e : null,
                                                                  date:
                                                                      '10/12/12'),
                                                            ),
                                                          );
                                                        },
                                                        text: 'View',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 75,
                                                          height: 25,
                                                          color:
                                                              Color(0xFF1456F1),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .subtitle2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      )
                                                    : FFButtonWidget(
                                                        onPressed: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (ctx) => TripPageVendor(
                                                                      bookingId: e.id.toString(),
                                                                      userAddress: e.rideRequestId != null ? e.rideEndAddress.toString() : e.deliveryAddress.toString() ?? '',
                                                                      // userAddress:
                                                                      //     e.deliveryAddress.toString() ??
                                                                      //         'Jabi lake Mall, Abuja',
                                                                      // userMobile: e.rideRequestId != null ? e.otherRiderPhoneNumber != null ? e.otherRiderPhoneNumber : e.deliveryMobile.toString() ?? '09055949934',
                                                                      userMobile: e.deliveryMobile.toString() ?? '09055949934',
                                                                      vendorAddress: e.rideRequestId != null ? e.rideStartAddress.toString() : e.storeAddress.toString() ?? '',
                                                                      // vendorAddress: e.storeAddress.toString() ?? '',
                                                                      rideData: e.rideRequestId != null ? e : null,
                                                                      date: '10/12/12')));
                                                        },
                                                        text: 'Start Trip',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 75,
                                                          height: 25,
                                                          color:
                                                              Color(0xFF1456F1),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .subtitle2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  ],
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ...provider.completedRequestModel!.data!.map((e) {
                                print('print e for me $e');
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                'assets/images/Rectangle_43.png',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SelectionArea(
                                                        child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Text(
                                                        'New completed Request',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    )),
                                                    SelectionArea(
                                                        child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Text(
                                                        'Pickup Location: ${e.rideRequestId != null ? e.rideStartAddress : e.storeAddress}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0x81000000),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    )),
                                                    SelectionArea(
                                                        child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Text(
                                                        'Destination: ${e.rideRequestId != null ? e.rideEndAddress : e.userAddress}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0x81000000),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    )),
                                                    // SelectionArea(
                                                    //     child: Text(
                                                    //       '08101013370',
                                                    //       style: FlutterFlowTheme
                                                    //           .of(context)
                                                    //           .bodyText1
                                                    //           .override(
                                                    //         fontFamily:
                                                    //         'Poppins',
                                                    //         color: Color(
                                                    //             0xFF7A7C7F),
                                                    //         fontSize: 8,
                                                    //         fontWeight:
                                                    //         FontWeight.w600,
                                                    //       ),
                                                    //     )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ...provider.cancelledRequestModel!.data!.map((e) {
                                print('print e for me $e');
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Container(
                                    width: 354,
                                    height: 92,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                'assets/images/Rectangle_43.png',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      'New cancelled Request',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Text(
                                                        'Pickup Location: ${e.rideRequestId != null ? e.rideStartAddress : e.storeAddress}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0x81000000),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    )),
                                                    SelectionArea(
                                                        child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Text(
                                                        'Destination: ${e.rideRequestId != null ? e.rideEndAddress : e.userAddress}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0x81000000),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    )),
                                                    // SelectionArea(
                                                    //     child: Text(
                                                    //       '08101013370',
                                                    //       style: FlutterFlowTheme
                                                    //           .of(context)
                                                    //           .bodyText1
                                                    //           .override(
                                                    //         fontFamily:
                                                    //         'Poppins',
                                                    //         color: Color(
                                                    //             0xFF7A7C7F),
                                                    //         fontSize: 8,
                                                    //         fontWeight:
                                                    //         FontWeight.w600,
                                                    //       ),
                                                    //     )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
