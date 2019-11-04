import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/core/routes/routes.dart';

class MainBottomNavigationBar {
  static BottomNavigationBar generate(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      onTap: (int index) => onTabTapped(context, index, currentIndex),
      currentIndex: currentIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Releases'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('User'),
        ),
      ],
    );
  }

  static void onTabTapped(
      BuildContext context, int newIndex, int currentIndex) {
    if (newIndex != currentIndex) {
      switch (newIndex) {
        case 0:
          Navigator.of(context).pushReplacementNamed(RoutePaths.releases);
          break;
        case 1:
          Navigator.of(context).pushReplacementNamed(RoutePaths.user);
          break;
        default:
      }
    }
  }
}
