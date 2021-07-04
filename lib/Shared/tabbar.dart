import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Screen/HomeContent/Restaurant/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Menuly',
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Colors.greenAccent
                    : Colors.blue[700],
                fontWeight: FontWeight.w700)),
      ),
      body: RestaurantMenu(),
    );
  }
}
