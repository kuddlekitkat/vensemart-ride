import 'package:flutter/widgets.dart';

class FFIcons {
  FFIcons._();

  static const String _iconsFamily = 'Icons';
  static const String _navIconFamily = 'NavIcon';
  static const String _navIconsFamily = 'NavIcons';
  static const String _drawerIconsFamily = 'DrawerIcons';
  static const String _myFlutterAppFamily = 'MyFlutterApp';
  static const String _accIconsFamily = 'AccIcons';

  // Icons
  static const IconData kvector1 = IconData(0xe800, fontFamily: _iconsFamily);

  // NavIcon
  static const IconData khamburger =
      IconData(0xe801, fontFamily: _navIconFamily);
  static const IconData kvector2 = IconData(0xe802, fontFamily: _navIconFamily);
  static const IconData kvector3 = IconData(0xe803, fontFamily: _navIconFamily);
  static const IconData kvector4 = IconData(0xe804, fontFamily: _navIconFamily);
  static const IconData kvector5 = IconData(0xe805, fontFamily: _navIconFamily);

  // NavIcons
  static const IconData khamburger2 =
      IconData(0xe800, fontFamily: _navIconsFamily);

  // DrawerIcons
  static const IconData kgroup154 =
      IconData(0xe805, fontFamily: _drawerIconsFamily);
  static const IconData kvector6 =
      IconData(0xe806, fontFamily: _drawerIconsFamily);

  // MyFlutterApp
  static const IconData kimageicon =
      IconData(0xe800, fontFamily: _myFlutterAppFamily);

  // AccIcons
  static const IconData kbank = IconData(0xe807, fontFamily: _accIconsFamily);
  static const IconData kverify = IconData(0xe808, fontFamily: _accIconsFamily);
}
