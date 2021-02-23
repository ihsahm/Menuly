import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/restaurant_list.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/AreaDetailPage/area_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantMenu extends StatefulWidget {
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  final double height = 400;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          runSpacing: 0.0,
          spacing: 2.0,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Burger & Pizza"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Injera"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Combo"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Vegeterian"),
                onPressed: () {
                  //  crudObj.getVegeterianData();
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Fasting"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.orange,
                child: Text("Pasta"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Restaurants nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        RestaurantList(),
      ],
    );
  }
}
