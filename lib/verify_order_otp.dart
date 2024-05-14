import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../backend/apiservices/validator.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../manage_bank_page/manage_bank_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/provider_services.dart';
import 'feedback_screen.dart';

class VerifyOrderOtp extends StatefulWidget {
  final String order_id;

  VerifyOrderOtp({Key? key, required this.order_id}) : super(key: key);

  @override
  _VerifyOrderOtpState createState() => _VerifyOrderOtpState();
}

class _VerifyOrderOtpState extends State<VerifyOrderOtp> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;
  final _globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    // providerServices?.getWithdrawHistory(context);
    // providerServices?.getWithdrawHistory(context);
    textController = TextEditingController();
  }

  void withdrawAmount(context) async {
    setState(() {});
    providerServices?.validateSmsUser(map: {
      "order_id": "${widget?.order_id}",
      "otp": "${textController?.text}",
    }, context: context, 
    orderId: widget.order_id.toString(),
    );

    // if (providerServices?.isSuccessful == true) {
     
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Please enter a valid OTP"),
    //     duration: Duration(seconds: 3),
    //   ));
    // }
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  void makeWithdrawal(context) async {
    if (_globalFormKey.currentState!.validate()) {
      setState(() {});
      providerServices?.validateSmsUser(map: {
        "order_id": "${widget.order_id}",
        "otp": "${textController?.text}",
      }, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.withdrawHistoryModel?.message == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            'Verify OTP',
            style: FlutterFlowTheme.of(context).title2.override(
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
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: SelectionArea(
                        child: Text(
                      'Verify OTP',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x65000000),
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                    )),
                  ),
                  Form(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: textController,
                          autofocus: true,
                          obscureText: false,
                          validator: Validators.validateString(),
                          decoration: InputDecoration(
                            hintText: 'Enter OTP',
                            hintStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0x52000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xCC000000),
                                    fontWeight: FontWeight.normal,
                                  ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: SelectionArea(
                        child: Text(
                      'please enter otp gotten from customer',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x81000000),
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                          ),
                    )),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      withdrawAmount(context);
                      // await Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.topToBottom,
                      //     duration: Duration(milliseconds: 300),
                      //     reverseDuration: Duration(milliseconds: 300),
                      //     child: ManageBankPageWidget(),
                      //   ),
                      // );
                    },
                    text: 'Proceed',
                    options: FFButtonOptions(
                      width: 221,
                      height: 46,
                      color: Color(0xFF1456F1),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}