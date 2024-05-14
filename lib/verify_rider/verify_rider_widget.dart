import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../provider/provider_services.dart';
import '../signup/signup_widget.dart';
import '../vehicle_details/vehicle_details_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class VerifyRiderWidget extends StatefulWidget {
  const VerifyRiderWidget({Key? key}) : super(key: key);

  @override
  _VerifyRiderWidgetState createState() => _VerifyRiderWidgetState();
}

class _VerifyRiderWidgetState extends State<VerifyRiderWidget> {
  TextEditingController? pinCodeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;

  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    pinCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.topToBottom,
                      duration: Duration(milliseconds: 100),
                      reverseDuration: Duration(milliseconds: 100),
                      child: SignupWidget(),
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: Color(0x7F000000),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 4,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SelectionArea(
                          child: Text(
                        'Verify your Account',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF1A1A2E),
                              fontSize: 24,
                            ),
                      )),
                      SelectionArea(
                          child: Text(
                        'An OTP has been sent to your email\n08101013370',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9595A4),
                              fontWeight: FontWeight.normal,
                            ),
                      )),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF1A1A2E),
                                  ),
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          enableActiveFill: false,
                          autoFocus: true,
                          showCursor: true,
                          cursorColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          obscureText: false,
                          pinTheme: PinTheme(
                            fieldHeight: 60,
                            fieldWidth: 60,
                            borderWidth: 2,
                            borderRadius: BorderRadius.circular(12),
                            shape: PinCodeFieldShape.box,
                            activeColor: Color(0xFF1456F1),
                            inactiveColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            selectedColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            activeFillColor: Color(0xFF1456F1),
                            inactiveFillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            selectedFillColor:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                          controller: pinCodeController,
                          onChanged: (_) => {},
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            'Didn’t recieve a code?',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF1A1A2E),
                                      fontWeight: FontWeight.w500,
                                    ),
                          )),
                          SelectionArea(
                              child: Text(
                            'Resend',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF1456F1),
                                      fontWeight: FontWeight.w500,
                                    ),
                          )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 1000),
                                reverseDuration: Duration(milliseconds: 1000),
                                child: VehicleDetailsWidget(),
                              ),
                            );
                          },
                          text: 'Verify',
                          options: FFButtonOptions(
                            width: 209,
                            height: 48,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
