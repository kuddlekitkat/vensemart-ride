import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/image_picker.dart';
import 'dart:io';
import '../nav_bar_page.dart';
import '../provider/provider_services.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textController5;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;
  final _pickImage = ImagePickerHandler();
  File? fileImage;

  final _globalFormKey = GlobalKey<FormState>();

  _formartFileImage(File? imageFile) {
    if (imageFile == null) return;
    return File(imageFile.path.replaceAll('\'', '').replaceAll('File: ', ''));
  }


  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getUserDetails();
    textController1 = TextEditingController();
    textController1?.text = providerServices?.userDetailModel?.data?.name ?? '';
    textController2 = TextEditingController();
    textController2?.text = providerServices?.userDetailModel?.data?.email ?? '';
    textController3 = TextEditingController();
    textController3?.text = providerServices?.userDetailModel?.data?.mobile ?? '';
    // textController4?.text = providerServices?.userDetailModel?.data?.mobile ?? '';
    // textController5?.text = providerServices?.userDetailModel?.data?.mobile ?? '';
  }



  void updateProfile(context) async {

        providerServices?.updateProfile(credentials: {
          "name": textController1?.text.trim(),
          "email": textController2?.text.trim(),
          "mobile": textController3?.text.trim(),
          // "address": addressController.text.trim(),
          // "gender": genderController.text.trim(),
          // "date_of_birth": dobController.text.trim(),
          "profile": MultipartFile.fromBytes(
              _formartFileImage(fileImage).readAsBytesSync(),
              filename: fileImage!.path.split("/").last),
        }, context: context);


  }




  // void updateProfile(context) async {
  //   if (_globalFormKey.currentState!.validate()) {
  //     if (fileImage != null) {
  //       providerServices?.updateProfile(credentials: {
  //         "name": textController1?.text.trim(),
  //         // "email": textController2?.text.trim(),
  //         // "mobile": textController3?.text.trim(),
  //         // "address": addressController.text.trim(),
  //         // "gender": genderController.text.trim(),
  //         // "date_of_birth": dobController.text.trim(),
  //         // "profile": MultipartFile.fromBytes(
  //         //     _formartFileImage(fileImage).readAsBytesSync(),
  //         //     filename: fileImage!.path.split("/").last),
  //       }, context: context);
  //     } else {
  //       providerServices?.updateProfile(credentials: {
  //         "name": textController1?.text.trim(),
  //         "email": textController2?.text.trim(),
  //         "mobile": textController3?.text.trim(),
  //         // "address": addressController.text.trim(),
  //         // "gender": genderController.text.trim(),
  //         // "date_of_birth": dobController.text.trim(),
  //       }, context: context);
  //     }
  //   }
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
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.userDetailModel?.data == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }
      return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 109,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1456F1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .topToBottom,
                                                  duration:
                                                      Duration(milliseconds: 100),
                                                  reverseDuration:
                                                      Duration(milliseconds: 100),
                                                  child: NavBarPage(
                                                      initialPage: 'HomePage'),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.chevron_left,
                                              color: Color(0x81000000),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              120, 0, 0, 0),
                                          child: SelectionArea(
                                              child: Text(
                                            'Edit Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Sora',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                fileImage != null
                                    ? GestureDetector(
                                  onTap: () => _getImage(context),
                                      child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 80, 0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:  CircleAvatar(
                                            radius: 50,
                                            backgroundImage: FileImage(fileImage!))

                                        // Image.asset(
                                        //   'assets/images/Group_201.png',
                                        //   width: 100,
                                        //   height: 100,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                  ),
                                ),
                                    ) : GestureDetector(
                                  onTap: () => _getImage(context),
                                      child: Align(

                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 80, 0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 50.0,
                                            // backgroundImage:
                                            // AssetImage("assets/images/dp.png"),
                                            child: CachedNetworkImage(
                                              imageUrl: provider
                                                  .userDetailModel?.data?.profile
                                                  .toString() ??
                                                  '',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  Container(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                              errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ),
                                ),
                                    ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 180, 0, 0),
                                    child: SelectionArea(
                                        child: Text(
                                      'Below are your personal details shared\non vensemart',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0x85000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: SelectionArea(
                        child: Text(
                      'Name',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x82060606),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                    )),
                  ),
                  TextFormField(

                    controller: textController1,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Aaron Mike',
                      hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Color(0x86000000),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: SelectionArea(
                        child: Text(
                      'Email',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x82060606),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                    )),
                  ),
                  TextFormField(
                    controller: textController2,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'iaarondikko@gmail.com',
                      hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Color(0x86000000),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: SelectionArea(
                        child: Text(
                      'Mobile Number',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x82060606),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                    )),
                  ),
                  TextFormField(
                    controller: textController3,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '+2348101013370',
                      hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Color(0x86000000),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x82000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            //         child: SelectionArea(
            //             child: Text(
            //           'Username',
            //           style: FlutterFlowTheme.of(context).bodyText1.override(
            //                 fontFamily: 'Poppins',
            //                 color: Color(0x82060606),
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //         )),
            //       ),
            //       TextFormField(
            //         controller: textController4,
            //         autofocus: true,
            //         obscureText: false,
            //         decoration: InputDecoration(
            //           hintText: 'aaronmike',
            //           hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
            //                 fontFamily: 'Poppins',
            //                 color: Color(0x86000000),
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x82000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x82000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           errorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x00000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           focusedErrorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x00000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           filled: true,
            //           fillColor: Colors.white,
            //           contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
            //         ),
            //         style: FlutterFlowTheme.of(context).bodyText1.override(
            //               fontFamily: 'Poppins',
            //               color: Colors.black,
            //             ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            //         child: SelectionArea(
            //             child: Text(
            //           'Address',
            //           style: FlutterFlowTheme.of(context).bodyText1.override(
            //                 fontFamily: 'Poppins',
            //                 color: Color(0x82060606),
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //         )),
            //       ),
            //       TextFormField(
            //         controller: textController5,
            //         autofocus: true,
            //         obscureText: false,
            //         decoration: InputDecoration(
            //           hintText: 'Abuja Nigeria',
            //           hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
            //                 fontFamily: 'Poppins',
            //                 color: Color(0x86000000),
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x82000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x82000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           errorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x00000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           focusedErrorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color(0x00000000),
            //               width: 0.5,
            //             ),
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           filled: true,
            //           fillColor: Colors.white,
            //           contentPadding:
            //               EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
            //         ),
            //         style: FlutterFlowTheme.of(context).bodyText1.override(
            //               fontFamily: 'Poppins',
            //               color: Colors.black,
            //             ),
            //         maxLines: 4,
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: FFButtonWidget(
                onPressed: () {
                  // print('Button pressed ...');
                  updateProfile(context);
                },
                text: 'Update',
                options: FFButtonOptions(
                  width: 300,
                  height: 40,
                  color: Color(0xFF1456F1),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
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
      );
    
    });
  }
}
