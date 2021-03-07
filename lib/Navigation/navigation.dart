import 'package:e_commerce/Screen/EventPage/event_page.dart';
import 'package:e_commerce/Screen/Search/search_screen.dart';
import 'package:e_commerce/Screen/Settings/settings.dart';
import 'package:e_commerce/Screen/Shared/tabbar.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      TabNavigation(),
      // SearchScreen(),
      EventPage(),
      Settings(),
    ];
    final _items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), title: Text('Home')),
      // BottomNavigationBarItem(
      //     icon: Icon(Icons.search_outlined), title: Text('Search')),
      BottomNavigationBarItem(
          icon: Icon(Icons.event_note_outlined), title: Text('Events')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined), title: Text('Settings')),
    ];
    assert(_pages.length == _items.length);

    final bottomNavBar = BottomNavigationBar(
        items: _items,
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        });
    return Scaffold(
      body: _pages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
