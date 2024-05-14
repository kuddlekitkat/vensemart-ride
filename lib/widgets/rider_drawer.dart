import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vensemart_delivery/notification_page/ride_history_page.dart';
import '../about_us/about_us_widget.dart';
import '../contact_u_s/contact_u_s_widget.dart';
// import '../flutter_flow/custom_icons.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../notification_page/notification_page_widget.dart';
import '../preferences/preferences_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../provider/provider_services.dart';
import '../wallet_page/wallet_page_widget.dart';

class RiderDrawer extends StatefulWidget {
  const RiderDrawer({Key? key}) : super(key: key);

  @override
  State<RiderDrawer> createState() => _RiderDrawerState();
}

class _RiderDrawerState extends State<RiderDrawer> {
  ProviderServices? providerServices;

  bool? switchListTileValue1;

  @override
  void initState() {
    super.initState();
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    providerServices?.getUserDetails();

    // from the provider services check if the user is online or not and set the switchListTileValue1 to the value
    switchListTileValue1 =
        providerServices?.userDetailModel?.data?.isOnline == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (_, provider, __) {
      if (provider.userDetailModel?.data == null) {
        return SpinKitCircle(
          color: Colors.blue[900],
        );
      }

      return Container(
        width: 325,
        child: Drawer(
          elevation: 16,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 325,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
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
                                      alignment: AlignmentDirectional(-0.8, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 90, 0, 0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Center(
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
                                                          image: imageProvider,
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 170, 0, 0),
                                      child: Text(
                                        '${providerServices?.userDetailModel?.data?.name}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 200, 0, 0),
                                        child: Text(
                                          '${providerServices?.userDetailModel?.data?.email}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF808080),
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
                      // switch list tile to change the online status of the user
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.circle,
                                color: switchListTileValue1 == true
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 3, 0, 0),
                                child: Text(
                                  'Online Status',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: SwitchListTile(
                                    value: switchListTileValue1!,
                                    activeColor: Color(0xFF1465F1),
                                    onChanged: (value) {
                                      setState(() {
                                        switchListTileValue1 = value;
                                        providerServices?.changeOnlineStatus();
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ProfilePageWidget()));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ProfilePageWidget()));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    FFIcons.kvector1,
                                    color: Color(0xFFBFBFBF),
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 3, 0, 0),
                                    child: Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF808080),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          NotificationPageWidget()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kvector2,
                                  color: Color(0xFFBFBFBF),
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 3, 0, 0),
                                  child: Text(
                                    'Notifications ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF808080),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => WalletPageWidget()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kgroup154,
                                  color: Color(0xFFBFBFBF),
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 3, 0, 0),
                                  child: Text(
                                    'Wallet',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF808080),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          RideHistoryPage()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kgroup154,
                                  color: Color(0xFFBFBFBF),
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 3, 0, 0),
                                  child: Text(
                                    'Ride History',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF808080),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ContactUSWidget()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kvector3,
                                  color: Color(0xFFBFBFBF),
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 3, 0, 0),
                                  child: Text(
                                    'Contact us',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF808080),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => AboutUsWidget())),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AboutUsWidget()));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    FFIcons.kvector5,
                                    color: Color(0xFFBFBFBF),
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 3, 0, 0),
                                    child: Text(
                                      'About us',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF808080),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => PreferencesWidget()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kvector4,
                                  color: Color(0xFFBFBFBF),
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 3, 0, 0),
                                  child: Text(
                                    'Preferences',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          providerServices?.logout(context);
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kvector6,
                                  color: Color(0xFFF05572),
                                  size: 20,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(10, 3, 0, 0),
                                  child: Text(
                                    'Logout',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
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
