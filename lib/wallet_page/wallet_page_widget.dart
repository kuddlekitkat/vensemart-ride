import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
// import '../main.dart';
import '../nav_bar_page.dart';
import '../provider/provider_services.dart';
import '../withdraw_page/withdraw_page_widget.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class WalletPageWidget extends StatefulWidget {
  const WalletPageWidget({Key? key}) : super(key: key);

  @override
  _WalletPageWidgetState createState() => _WalletPageWidgetState();
}

class _WalletPageWidgetState extends State<WalletPageWidget> {
  ProviderServices? providerServices;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getWithdrawHistory(context);
    providerServices?.getWalletHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.walletModel?.message == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }

      if (provider.walletModel?.data == null) {
        return Text('No wallet history');
      }
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.topToBottom,
                      duration: Duration(milliseconds: 100),
                      reverseDuration: Duration(milliseconds: 100),
                      child: NavBarPage(initialPage: 'HomePage'),
                    ),
                  );
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: Color(0x85000000),
                  size: 24,
                ),
              ),
            ),
          ),
          title: Text(
            'Wallet',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF1456F1),
                  fontSize: 15,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 134,
                      decoration: BoxDecoration(
                        color: Color(0xFF1456F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectionArea(
                                      child: Text(
                                    'Total Balance',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  )),
                                  SelectionArea(
                                      child: Text(
                                    'NGN ${providerServices?.walletModel?.data!.walletAmount ?? 0}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  )),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.topToBottom,
                                          duration: Duration(milliseconds: 100),
                                          reverseDuration:
                                              Duration(milliseconds: 100),
                                          child: WithdrawPageWidget(),
                                        ),
                                      );
                                    },
                                    text: 'Withdraw',
                                    options: FFButtonOptions(
                                      width: 113,
                                      height: 30,
                                      color: Colors.white,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF1C82CA),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                              child: Icon(
                                FFIcons.kgroup154,
                                color: Color(0xFFF6F8FE),
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: SelectionArea(
                          child: Text(
                        'Withdrawal History',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0x7C000000),
                              fontWeight: FontWeight.w500,
                            ),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...provider.walletModel!.data!.transactionhistory!
                                .map((e) {
                              print('print e for me $e');

                              // SelectionArea(
                              //     child: Text(
                              //   'Friday, Sept 18,2022',
                              //   style:
                              //       FlutterFlowTheme.of(context).bodyText1.override(
                              //             fontFamily: 'Poppins',
                              //             color: Color(0xFF7A7C7F),
                              //             fontSize: 10,
                              //             fontWeight: FontWeight.normal,
                              //           ),
                              // )),
                              //

                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 2.5,
                                              borderWidth: 1,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFE8F2F1),
                                              icon: Icon(
                                                Icons.arrow_upward,
                                                color: Color(0xFF407B75),
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    'Money sent successfully',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0x81000000),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'AARON ILIYA DIKKO',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                        child: SelectionArea(
                                            child: Text(
                                          '₦2,000',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF0FAF97),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )),
                                      ),
                                    ],
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
            ),
          ),
        ),
      );
    });
  }
}
