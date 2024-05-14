import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../add_bank_account/add_bank_account_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../payment_successful/payment_successful_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/provider_services.dart';

class ManageBankPageWidget extends StatefulWidget {
  const ManageBankPageWidget({Key? key}) : super(key: key);

  @override
  _ManageBankPageWidgetState createState() => _ManageBankPageWidgetState();
}

class _ManageBankPageWidgetState extends State<ManageBankPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProviderServices? providerServices;

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getBankDetails(context);
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.bankDetail?.message == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }

      if (provider.bankDetail?.data == null) {
        return Text('No banks Available');
      }

      return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme
            .of(context)
            .primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF1456F1),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              fillColor: Colors.white,
              icon: Icon(
                Icons.chevron_left,
                color: Color(0x7F000000),
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
                print('IconButton pressed ...');
              },
            ),
          ),
          title: Text(
            'Bank Account',
            style: FlutterFlowTheme
                .of(context)
                .title2
                .override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
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
                padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: SelectionArea(
                              child: Text(
                                'Add and remove bank account for withdrawals,add up to\n3 account',
                                textAlign: TextAlign.start,
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Color(0x7D000000),
                                  fontSize: 11,
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(19, 0, 0, 20),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.topToBottom,
                                duration: Duration(milliseconds: 2000),
                                reverseDuration: Duration(milliseconds: 2000),
                                child: AddBankAccountWidget(),
                              ),
                            );
                          },
                          text: 'Add Bank Account',
                          options: FFButtonOptions(
                            width: 350,
                            height: 40,
                            color: Color(0xFF1456F1),
                            textStyle:
                            FlutterFlowTheme
                                .of(context)
                                .subtitle2
                                .override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SelectionArea(
                          child: Text(
                            'Bank Accounts',
                            style: FlutterFlowTheme
                                .of(context)
                                .bodyText1
                                .override(
                              fontFamily: 'Poppins',
                              color: Color(0x7D000000),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [



    ...provider.bankDetail!.data!.map((e) {
    print('print e for me $e');



                         return  Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 15),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    duration: Duration(milliseconds: 400),
                                    reverseDuration: Duration(
                                        milliseconds: 400),
                                    child: PaymentSuccessfulWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 79,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          SelectionArea(
                                              child: Text(
                                                '${e.accountHolderName}',
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xB5000000),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                          SelectionArea(
                                              child: Text(
                                                '${e.bank}',
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0x7F000000),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                          SelectionArea(
                                              child: Text(
                                                '${e.accountNumber}',
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0x83000000),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ],
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Color(0xFFF05572),
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                }).toList()



                          // Padding(
                          //   padding: EdgeInsetsDirectional.fromSTEB(
                          //       0, 0, 0, 15),
                          //   child: Container(
                          //     width: double.infinity,
                          //     height: 79,
                          //     decoration: BoxDecoration(
                          //       color: FlutterFlowTheme
                          //           .of(context)
                          //           .secondaryBackground,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Padding(
                          //       padding: EdgeInsetsDirectional.fromSTEB(
                          //           10, 10, 10, 10),
                          //       child: Row(
                          //         mainAxisSize: MainAxisSize.max,
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Column(
                          //             mainAxisSize: MainAxisSize.max,
                          //             crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //             children: [
                          //               SelectionArea(
                          //                   child: Text(
                          //                     'Access Bank',
                          //                     style: FlutterFlowTheme
                          //                         .of(context)
                          //                         .bodyText1
                          //                         .override(
                          //                       fontFamily: 'Poppins',
                          //                       color: Color(0xB5000000),
                          //                       fontWeight: FontWeight.w500,
                          //                     ),
                          //                   )),
                          //               SelectionArea(
                          //                   child: Text(
                          //                     '0014388261',
                          //                     style: FlutterFlowTheme
                          //                         .of(context)
                          //                         .bodyText1
                          //                         .override(
                          //                       fontFamily: 'Poppins',
                          //                       color: Color(0x7F000000),
                          //                       fontSize: 10,
                          //                       fontWeight: FontWeight.w500,
                          //                     ),
                          //                   )),
                          //               SelectionArea(
                          //                   child: Text(
                          //                     'AARON ILIYA DIKKO',
                          //                     style: FlutterFlowTheme
                          //                         .of(context)
                          //                         .bodyText1
                          //                         .override(
                          //                       fontFamily: 'Poppins',
                          //                       color: Color(0x83000000),
                          //                       fontSize: 10,
                          //                       fontWeight: FontWeight.w500,
                          //                     ),
                          //                   )),
                          //             ],
                          //           ),
                          //           FaIcon(
                          //             FontAwesomeIcons.trashAlt,
                          //             color: Color(0xFFF05572),
                          //             size: 24,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //
                          //
                          //


                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

  }
}
