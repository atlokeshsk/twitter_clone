import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'assets_constant.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: Builder(builder: (context) {
        return SvgPicture.asset(
          AssetsConstants.twitterLogo,
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.primary,
        );
      }),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    Text('Feed Screen'),
    Text('Search Screen'),
    Text('Notification Screen'),
  ];
}
