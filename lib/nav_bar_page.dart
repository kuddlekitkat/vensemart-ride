import 'package:flutter/material.dart';
import 'package:vensemart_delivery/request_page/request_page_widget.dart';

import 'account_page/account_page_widget.dart';
import 'chat_page/chat_page_widget.dart';
import 'flutter_flow/custom_icons.dart';
import 'home_page/home_page_widget.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'RequestPage': RequestPageWidget(),
      'ChatPage': ChatPageWidget(),
      'AccountPage': AccountPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF1456F1),
        unselectedItemColor: Color(0xFF7A7C7F),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kvector5,
              size: 20,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 20,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kvector2,
              size: 20,
            ),
            activeIcon: Icon(
              FFIcons.kvector2,
              size: 24,
            ),
            label: 'Request',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kvector3,
              size: 20,
            ),
            activeIcon: Icon(
              FFIcons.kvector3,
              size: 24,
            ),
            label: 'Chat',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kvector4,
              size: 24,
            ),
            activeIcon: Icon(
              FFIcons.kvector1,
              size: 24,
            ),
            label: 'Account',
            tooltip: '',
          )
        ],
      ),
    );
  }
}