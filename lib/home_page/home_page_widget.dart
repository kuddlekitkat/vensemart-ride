import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:vensemart_delivery/widgets/rider_drawer.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

import '../provider/provider_services.dart';
import '../request_page/request_page_widget.dart';
import '../withdraw_page/withdraw_page_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'iconOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;

  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getWithdrawHistory(context);
    providerServices?.serviceHome();
    providerServices?.getUserDetails();
  }

  //function to get user location

  double totalEarnings() {
    return double.parse(providerServices
                ?.withdrawHistoryModel?.data?.walletAmount
                .toString() ??
            '0') +
        double.parse(providerServices?.withdrawHistoryModel?.data?.cWalletAmount
                .toString() ??
            '0');
    // return double.parse(providerServices?.withdrawHistoryModel?.data?.walletAmount.toString() ?? 0) + double.parse(providerServices?.withdrawHistoryModel?.data?.cWalletAmount ?? 0);
    // return providerServices?.withdrawHistoryModel?.data?.walletAmount ??
    //     0 + providerServices?.withdrawHistoryModel?.data?.cWalletAmount ??
    //     0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      drawer: RiderDrawer(),
      appBar: AppBar(
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
        ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
              //   child: Image.asset(
              //     'assets/images/Vector_(1).png',
              //     width: 15,
              //     height: 15,
              //     fit: BoxFit.contain,
              //   ),
              // ),

              //Text widget with line across it

              Align(
                alignment: AlignmentDirectional(0, 0.5),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                  child: SelectionArea(
                      child: Text(
                    'Vensemart Rider App',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0x7C101213),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                  )),
                ),
              ),
            ],
          ),
        ),
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
      body: Consumer<ProviderServices>(builder: (_, provider, __) {
        print('object ${provider.withdrawHistoryModel?.data}');
        if (provider.serviceHomeModel?.data == null) {
          return Center(
              child: const SpinKitCircle(
            color: Colors.blue,
          ));
        } else {
          return SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // show online status with a green dot if online and red if offline
                      SizedBox(height: 5),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Welcome, ${provider?.userDetailModel?.data?.name ?? ''}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              provider?.userDetailModel!.data!.isOnline !=
                                          null &&
                                      provider?.userDetailModel!.data!
                                              .isOnline ==
                                          0
                                  ? Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Text(
                                            'Offline',
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF0000),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Text(
                                            'Online',
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00FF00),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total Earnings',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'NGN ${totalEarnings().toStringAsFixed(2)}',
                            // 'NGN ${providerServices?.withdrawHistoryModel?.data?.walletAmount ?? 0 + providerServices?.withdrawHistoryModel?.data?.cWalletAmount ?? 0}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            // width 50%
                            width: MediaQuery.of(context).size.width / 2.1,
                            // width: double.infinity,
                            height: 108,
                            decoration: BoxDecoration(
                              color: Color(0xFF1456F1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectionArea(
                                            child: Text(
                                          'Credit Balance',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        )),
                                        SelectionArea(
                                            child: Text(
                                          'NGN ${providerServices?.withdrawHistoryModel?.data?.walletAmount ?? 0}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )),
                                        SizedBox(height: 15),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .topToBottom,
                                                duration:
                                                    Duration(milliseconds: 600),
                                                reverseDuration:
                                                    Duration(milliseconds: 600),
                                                child: WithdrawPageWidget(),
                                              ),
                                            );
                                          },
                                          text: 'Withdraw',
                                          options: FFButtonOptions(
                                            width: 118,
                                            height: 30,
                                            color: Colors.white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF1C82CA),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 15, 0),
                                    child: Icon(
                                      FFIcons.kgroup154,
                                      color: Color(0xFFF6F8FE),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),

                          Container(
                            // width 50%
                            width: MediaQuery.of(context).size.width / 2.4,
                            // width: double.infinity,
                            height: 108,
                            decoration: BoxDecoration(
                              color: Color(0xFFFD5F88),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectionArea(
                                            child: Text(
                                          'Amount to remit',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        )),
                                        SelectionArea(
                                            child: Text(
                                          'NGN ${providerServices?.withdrawHistoryModel?.data?.cWalletAmount ?? 0}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 15, 0),
                                    child: Icon(
                                      FFIcons.kgroup154,
                                      color: Color(0xFFF6F8FE),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

//  credit
                        ],
                      ),

                      SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                        child: SelectionArea(
                            child: Text(
                          'Today’s report',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                        )),
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => RequestPageWidget(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 5.3,
                              decoration: BoxDecoration(
                                color: Color(0xFFFD5F88),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 15, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 7, 7, 7),
                                        child: Image.asset(
                                          'assets/images/Vector_time.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      '${providerServices?.serviceHomeModel?.data?.pendingOrder ?? 0}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF6F8FE),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Pending Request',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF6F8FE),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              height: MediaQuery.of(context).size.height / 5.3,
                              decoration: BoxDecoration(
                                color: Color(0xFF1456F1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 15, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 7, 7, 7),
                                        child: Image.asset(
                                          'assets/images/completed.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      '${providerServices?.serviceHomeModel?.data?.completedOrder ?? 0}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF6F8FE),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Completed  Request',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFF6F8FE),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      //   child: SelectionArea(
                      //       child: Text(
                      //     'New orders',
                      //     style: FlutterFlowTheme.of(context).bodyText1.override(
                      //           fontFamily: 'Poppins',
                      //           color: Color(0xB4000000),
                      //         ),
                      //   )),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      //   child: Container(
                      //     width: 354,
                      //     height: 92,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.max,
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Image.asset(
                      //             'assets/images/Rectangle_43.png',
                      //             width: 60,
                      //             height: 60,
                      //             fit: BoxFit.cover,
                      //           ),
                      //           Padding(
                      //             padding:
                      //                 EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.max,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 SelectionArea(
                      //                     child: Text(
                      //                   'New booking request',
                      //                   style: FlutterFlowTheme.of(context)
                      //                       .bodyText1
                      //                       .override(
                      //                         fontFamily: 'Poppins',
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.w500,
                      //                       ),
                      //                 )),
                      //                 SelectionArea(
                      //                     child: Text(
                      //                   'Location: Garki area 11 Abuja',
                      //                   style: FlutterFlowTheme.of(context)
                      //                       .bodyText1
                      //                       .override(
                      //                         fontFamily: 'Poppins',
                      //                         color: Color(0x81000000),
                      //                         fontSize: 8,
                      //                         fontWeight: FontWeight.w500,
                      //                       ),
                      //                 )),
                      //                 SelectionArea(
                      //                     child: Text(
                      //                   'Destination: Amina’s court Apo',
                      //                   style: FlutterFlowTheme.of(context)
                      //                       .bodyText1
                      //                       .override(
                      //                         fontFamily: 'Poppins',
                      //                         color: Color(0x81000000),
                      //                         fontSize: 8,
                      //                         fontWeight: FontWeight.w500,
                      //                       ),
                      //                 )),
                      //                 SelectionArea(
                      //                     child: Text(
                      //                   '08101013370',
                      //                   style: FlutterFlowTheme.of(context)
                      //                       .bodyText1
                      //                       .override(
                      //                         fontFamily: 'Poppins',
                      //                         color: Color(0xFF7A7C7F),
                      //                         fontSize: 8,
                      //                         fontWeight: FontWeight.w600,
                      //                       ),
                      //                 )),
                      //               ],
                      //             ),
                      //           ),
                      //           FFButtonWidget(
                      //             onPressed: () async {
                      //               await Navigator.push(
                      //                 context,
                      //                 PageTransition(
                      //                   type: PageTransitionType.fade,
                      //                   duration: Duration(milliseconds: 0),
                      //                   reverseDuration: Duration(milliseconds: 0),
                      //                   child:
                      //                       NavBarPage(initialPage: 'RequestPage'),
                      //                 ),
                      //               );
                      //             },
                      //             text: 'View',
                      //             options: FFButtonOptions(
                      //               width: 75,
                      //               height: 25,
                      //               color: Color(0xFF1456F1),
                      //               textStyle: FlutterFlowTheme.of(context)
                      //                   .subtitle2
                      //                   .override(
                      //                     fontFamily: 'Poppins',
                      //                     color: Colors.white,
                      //                   ),
                      //               borderSide: BorderSide(
                      //                 color: Colors.transparent,
                      //                 width: 1,
                      //               ),
                      //               borderRadius: BorderRadius.circular(20),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
