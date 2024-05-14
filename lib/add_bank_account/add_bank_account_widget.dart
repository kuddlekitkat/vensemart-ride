import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../provider/provider_services.dart';

class AddBankAccountWidget extends StatefulWidget {
  const AddBankAccountWidget({Key? key}) : super(key: key);

  @override
  _AddBankAccountWidgetState createState() => _AddBankAccountWidgetState();
}

class _AddBankAccountWidgetState extends State<AddBankAccountWidget> {
  String? dropDownValue;
  TextEditingController? textController1;
  TextEditingController? textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;
  String? selectedValue;

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    super.initState();
    providerServices?.getBankList(context);

    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  void addBankDetails(context) async {
    setState(() {});
    providerServices?.addBankDetails(map: {
      "bank_code": selectedValue.toString(),
      "account_number": "${textController1?.text}",
      "account_name": "${textController2?.text}",
    }, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.bankList?.message == null) {
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
              onPressed: () async {
                addBankDetails(context);
                // await Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.topToBottom,
                //     duration: Duration(milliseconds: 100),
                //     reverseDuration: Duration(milliseconds: 100),
                //     child: ManageBankPageWidget(),
                //   ),
                // );
              },
            ),
          ),
          title: Text(
            'Add Bank Accounts ',
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
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: Container(
                      // borderColor: Colors.transparent,
                      // //   borderWidth: 0,
                      //   borderRadius: 10,
                      //   margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      decoration: BoxDecoration(
                          // borderColor: Colors.transparent,
                          // //   borderWidth: 0,
                          //   borderRadius: 10,
                          color: Color.fromRGBO(250, 250, 254, 1),
                          borderRadius:
                              BorderRadius.circular(12.0) //<-- SEE HERE
                          ),
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Select Bank',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: providerServices?.bankList?.data
                                ?.map((item) => DropdownMenuItem<String>(
                                      value: item.code.toString(),
                                      child: Text(
                                        item.name.toString(),
                                        style: TextStyle(
                                          //ios : 1.5
                                          // fontSize: 2.0 *
                                          //     MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.01,
                                          fontFamily: 'Poppins',
                                          color: Color(0x75000000),
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            // buttonHeight: screenHeight / 11,
                            // buttonWidth: screenWidth / 1.05,
                            // itemHeight: screenHeight / 17,
                          ),
                        ),
                      ),
                    ),
                    // child: FlutterFlowDropDown(
                    //   options: ['Access Bank'],
                    //   onChanged: (val) => setState(() => dropDownValue = val),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 50,
                    //   textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                    //         fontFamily: 'Poppins',
                    //         color: Color(0x75000000),
                    //         fontSize: 13,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //   hintText: 'Select Bank',
                    //   fillColor: Colors.white,
                    //   elevation: 2,
                    //   borderColor: Colors.transparent,
                    //   borderWidth: 0,
                    //   borderRadius: 10,
                    //   margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                    //   hidesUnderline: true,
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: textController1,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Account Number',
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
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0x65000000),
                              fontWeight: FontWeight.normal,
                            ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: textController2,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Account Name',
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
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x65000000),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 19, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        addBankDetails(context);
                        // await Navigator.pushAndRemoveUntil(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.leftToRight,
                        //     duration: Duration(milliseconds: 100),
                        //     reverseDuration: Duration(milliseconds: 100),
                        //     child: ManageBankPageWidget(),
                        //   ),
                        //   (r) => false,
                        // );
                      },
                      text: 'Add Bank Account',
                      options: FFButtonOptions(
                        width: 250,
                        height: 40,
                        color: Color(0xFF1456F1),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 13,
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
