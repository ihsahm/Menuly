import 'package:e_commerce/Consts/icons.dart';
import 'package:e_commerce/Screen/EventPage/event_page.dart';
import 'package:e_commerce/Screen/Settings/settings.dart';
import 'package:e_commerce/Shared/tabbar.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': TabNavigation(),
      },
      //     {
      //     'page':
      // MoviesPage(),
      //   },
      {
        'page': EventPage(),
      },
      {
        'page': SettingsPage(),
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            IconsData.home,
            size: 25,
          ),
          title: Text('Home')),
      //BottomNavigationBarItem(icon: Icon(Icons.movie), title: Text('Movies')),
      BottomNavigationBarItem(
          icon: Icon(IconsData.eventOutlined), title: Text('Events')),
      BottomNavigationBarItem(
          icon: Icon(IconsData.settings), title: Text('Settings')),
    ];
    assert(_pages.length == _items.length);

    final bottomNavBar = BottomNavigationBar(
        items: _items,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _selectedPage);
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
