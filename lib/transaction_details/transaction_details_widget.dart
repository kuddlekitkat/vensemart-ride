import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../nav_bar_page.dart';
import '../provider/provider_services.dart';

class TransactionDetailsWidget extends StatefulWidget {
  const TransactionDetailsWidget({Key? key}) : super(key: key);

  @override
  _TransactionDetailsWidgetState createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;

  @override
  void initState() {
    // TODO: implement initState
    providerServices = Provider.of<ProviderServices>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF6F8FE),
      appBar: AppBar(
        backgroundColor: Color(0xFF1456F1),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            fillColor: Colors.white,
            icon: Icon(
              Icons.chevron_left,
              color: Color(0x7F000000),
              size: 29,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.topToBottom,
                  duration: Duration(milliseconds: 700),
                  reverseDuration: Duration(milliseconds: 700),
                  child: NavBarPage(initialPage: 'HomePage'),
                ),
              );
            },
          ),
        ),
        title: Text(
          'Transaction details',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
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
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Amount           ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          ' ₦20,000 ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Bank Name:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          'Stanbicibtc Bank',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Account Number:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          '0014388261',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Account Name:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          ' Aaron Iliya Dikko',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Transfer fee:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          '₦10',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Paid on:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x7F000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: SelectionArea(
                                            child: Text(
                                          '18 Sept 2022  12:35',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 800),
                          reverseDuration: Duration(milliseconds: 800),
                          child: NavBarPage(initialPage: 'HomePage'),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'Download Receipt',
                    options: FFButtonOptions(
                      width: 182,
                      height: 49,
                      color: Color(0xFF1456F1),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
