import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce/Screen/EventPage/event_page.dart';
import 'package:e_commerce/Screen/Settings/settings.dart';
import 'package:e_commerce/Screen/Shared/tabbar.dart';
import 'package:e_commerce/Services/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentTabIndex = 0;

  final List<Message> messages = [];
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _messaging.getToken().then((pushtokens) {
      FirebaseFirestore.instance
          .collection('pushtokens')
          .add({pushtokens: pushtokens});
    });
    _messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  // @override
  // void initState() {
  //   super.initState();

  //   _messaging.getToken().then((token) {
  //     print(token);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      TabNavigation(),
      // SearchScreen(),
      EventPage(),
      SettingsPage(),
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

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('No internet connection'),
              content: Text(
                  'Can not find an internet connection please check your internet settings!'),
              actions: [
                FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }
}
