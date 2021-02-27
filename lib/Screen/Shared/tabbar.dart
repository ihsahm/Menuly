import 'package:e_commerce/Contents/HomeContent/HomeList/Cafe/cafe.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/hotel.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Parking/parking.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      RestaurantMenu(),
      //  CafeMenu(),
      Hotel(),
      Parking(),
      CafeMenu(),
    ];
    final tabIcon = <Tab>[
      Tab(
        icon: Icon(
          Icons.dinner_dining,
          color: Colors.red[800],
        ),
        child: Text(
          'Restaurants',
          style: TextStyle(color: Colors.red[800]),
        ),
      ),
      // Tab(
      //   icon: Icon(
      //     LineariconsFree.coffee_cup,
      //     color: Colors.red[800],
      //   ),
      //   child: Text(
      //     'Cafes',
      //     style: TextStyle(color: Colors.red[800]),
      //   ),
      // ),
      Tab(
        icon: Icon(
          Icons.hotel,
          color: Colors.red[800],
        ),
        child: Text(
          'Hotels',
          style: TextStyle(color: Colors.red[800]),
        ),
      ),
      Tab(
        icon: Icon(
          FontAwesome5.parking,
          color: Colors.red[800],
        ),
        child: Text(
          'Parking',
          style: TextStyle(color: Colors.red[800]),
        ),
      ),
      Tab(
        icon: Icon(
          FontAwesome.building,
          color: Colors.red[800],
        ),
        child: Text(
          'Guest House',
          style: TextStyle(color: Colors.red[800]),
        ),
      ),
    ];
    return DefaultTabController(
      length: tabIcon.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('eFood', style: TextStyle(color: Colors.blue[700])),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            isScrollable: true,
            tabs: tabIcon,
          ),
        ),
        body: TabBarView(children: tabPages),
      ),
    );
  }
}
