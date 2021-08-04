import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Screen/HomeContent/Restaurant/restaurant.dart';
import 'package:flutter/material.dart';

class TabNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Menuly',
            style: TextStyle(
                color: ColorsConst.blue700, fontWeight: FontWeight.w700)),
      ),
      body: RestaurantMenu(),
    );
  }
}
