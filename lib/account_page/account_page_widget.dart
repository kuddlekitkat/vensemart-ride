import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/index.dart';
import '../backend/core/session_manager.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../get_started/get_started_widget.dart';
import '../manage_bank_page/manage_bank_page_widget.dart';
import '../preferences/preferences_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../provider/provider_services.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/image_picker.dart';
import 'dart:io';

class AccountPageWidget extends StatefulWidget {
  const AccountPageWidget({Key? key}) : super(key: key);

  @override
  _AccountPageWidgetState createState() => _AccountPageWidgetState();
}

class _AccountPageWidgetState extends State<AccountPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;

  final _pickImage = ImagePickerHandler();
  File? fileImage;

  // final _globalFormKey = GlobalKey<FormState>();

  // _formartFileImage(File? imageFile) {
  //   if (imageFile == null) return;
  //   return File(imageFile.path.replaceAll('\'', '').replaceAll('File: ', ''));
  // }

  void _getImage(BuildContext context) {
    try {
      _pickImage.pickImage(
          context: context,
          file: (file) {
            fileImage = file;
            setState(() {});
          });
    } catch (e) {}
  }

  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.serviceHomeModel?.data == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFAFAFA),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Color(0xFF1465F1),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.1, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 90, 0, 0),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => _getImage(context),
                                    child:
                                        // provider.userDetailModel!.data!.profile != null
                                        //     ? Center(
                                        //         child: CachedNetworkImage(
                                        //           imageUrl:
                                        //               provider.userDetailModel!.data!.profile!,
                                        //           placeholder: (
                                        //             context,
                                        //             url,
                                        //           ) =>
                                        //               Container(
                                        //                   margin: const EdgeInsets.all(10),
                                        //                   child: const SpinKitCircle(
                                        //                     color: Colors.grey,
                                        //                   )),
                                        //           errorWidget: (context, url, error) =>
                                        //               const Icon(Icons.error),
                                        //         ),
                                        //       ):
                                        fileImage != null
                                            ? Center(
                                                child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        FileImage(fileImage!)),
                                              )
                                            : Center(
                                                child: CircleAvatar(
                                                  radius: 50.0,
                                                  // backgroundImage:
                                                  // AssetImage("assets/images/dp.png"),
                                                  child: CachedNetworkImage(
                                                    imageUrl: provider
                                                            .userDetailModel
                                                            ?.data
                                                            ?.profile
                                                            .toString() ??
                                                        '',
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.topToBottom,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 200),
                        child: ProfilePageWidget(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kvector4,
                                color: Colors.black,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Profile',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB1000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Manage profile',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x81000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ManageBankPageWidget()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kbank,
                                color: Colors.black,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Bank Account',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB1000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Manage bank details',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x81000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
              //   child: InkWell(
              //     onTap: () async {
              //       await Navigator.push(
              //         context,
              //         PageTransition(
              //           type: PageTransitionType.topToBottom,
              //           duration: Duration(milliseconds: 200),
              //           reverseDuration: Duration(milliseconds: 200),
              //           child: AccountVerifyPageWidget(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               mainAxisSize: MainAxisSize.max,
              //               children: [
              //                 Icon(
              //                   FFIcons.kverify,
              //                   color: Colors.black,
              //                   size: 24,
              //                 ),
              //                 Padding(
              //                   padding:
              //                       EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       SelectionArea(
              //                           child: Text(
              //                         'Account Verification ',
              //                         style: FlutterFlowTheme.of(context)
              //                             .bodyText1
              //                             .override(
              //                               fontFamily: 'Poppins',
              //                               color: Color(0xB1000000),
              //                               fontWeight: FontWeight.w500,
              //                             ),
              //                       )),
              //                       SelectionArea(
              //                           child: Text(
              //                         'Verify your identity to be verified',
              //                         style: FlutterFlowTheme.of(context)
              //                             .bodyText1
              //                             .override(
              //                               fontFamily: 'Poppins',
              //                               color: Color(0x81000000),
              //                               fontSize: 10,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                       )),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Icon(
              //               Icons.keyboard_arrow_right,
              //               color: Colors.black,
              //               size: 24,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
              //   child: InkWell(
              //     onTap: () async {
              //       await Navigator.push(
              //         context,
              //         PageTransition(
              //           type: PageTransitionType.topToBottom,
              //           duration: Duration(milliseconds: 200),
              //           reverseDuration: Duration(milliseconds: 200),
              //           child: RateAppWidget(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               mainAxisSize: MainAxisSize.max,
              //               children: [
              //                 Icon(
              //                   FFIcons.kvector4,
              //                   color: Colors.black,
              //                   size: 24,
              //                 ),
              //                 Padding(
              //                   padding:
              //                       EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       SelectionArea(
              //                           child: Text(
              //                         'Rate our App',
              //                         style: FlutterFlowTheme.of(context)
              //                             .bodyText1
              //                             .override(
              //                               fontFamily: 'Poppins',
              //                               color: Color(0xB1000000),
              //                               fontWeight: FontWeight.w500,
              //                             ),
              //                       )),
              //                       SelectionArea(
              //                           child: Text(
              //                         'How do you feel about our app',
              //                         style: FlutterFlowTheme.of(context)
              //                             .bodyText1
              //                             .override(
              //                               fontFamily: 'Poppins',
              //                               color: Color(0x81000000),
              //                               fontSize: 10,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                       )),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Icon(
              //               Icons.keyboard_arrow_right,
              //               color: Colors.black,
              //               size: 24,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.topToBottom,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 200),
                        child: PreferencesWidget(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.gear,
                                color: Colors.black,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Preferences',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB1000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Customise vensemart to suit you',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x81000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.topToBottom,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 200),
                        child: GetStartedWidget(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kvector6,
                                color: Colors.black,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Logout',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB1000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Sign out from vensemart',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x81000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: InkWell(
                  onTap: () async {
                    showAlertDialog(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Delete Account',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xB1000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      'Delete Your Account',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x81000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void deleteAccount() {
    providerServices?.deleteAccount(map: {
      "user_id": "${providerServices?.userDetailModel?.data?.id}",
    }, context: context);
    SessionManager.instance.logOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => SignWithEmailWidget()));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("YES", style: TextStyle(color: Colors.red)),
      onPressed: () {
        deleteAccount();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "NO",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Account Deletion Disclaimer"),
      content: Text("Would you like to delete your account forever?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
