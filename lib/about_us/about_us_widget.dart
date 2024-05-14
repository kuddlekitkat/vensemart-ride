import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../nav_bar_page.dart';
import '../provider/provider_services.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProviderServices? providerServices;
  @override
  void initState() {
    providerServices = Provider.of<ProviderServices>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          fillColor: Colors.white,
          icon: Icon(
            Icons.chevron_left,
            color: Color(0x7F000000),
            size: 30,
          ),
          onPressed: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
                reverseDuration: Duration(milliseconds: 0),
                child: NavBarPage(initialPage: 'HomePage'),
              ),
              (r) => false,
            );
          },
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
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 646,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: SelectionArea(
                                child: Text(
                              'About Us',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            )),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: SelectionArea(
                                child: Text(
                              'Vensemart is a bespoke user friendly vendor and service providers solution, designed to easily connect tested, trusted, verified and certified professionalservice providers (freelancers, sme\'s and corporate companies) to daily personal,home and corporate service needs from personal grooming (barbing/hairdo, makeup,massage and dressing), electrical repairs, mechanical repairs, to general buildingconstruction and repairs. It is a guaranteed marketplace for person home and office daily consumptions shopping and a reliable logistic service delivery solution.\nIt\'s a one-stop spot that guarantees affordable, effective, efficient, safe and timely service delivery and products that takes the hassle of transporting home service needs to service outlets, inconveniences to cue at shopping mall and disappointment by logistics delivery agencies, and translates value for money.\nIt enables the end users to access closest and reliable services within 3 minutes of location proximity, book and manage appointments at convenience and avoid queuing at public outlet for service needs with a relaxed and first class user experience.\nVensemart Apps encourages business growth and curbs the increasing rate of job lost and global economic downturn, networknig onckexpon dingines%h realm economy (freelancing) to the corporate companies.',
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0x7F000000),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 29, 0, 0),
                    child: SelectionArea(
                        child: Text(
                      'v 1.0',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0x7F000000),
                            fontSize: 12,
                          ),
                    )),
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
