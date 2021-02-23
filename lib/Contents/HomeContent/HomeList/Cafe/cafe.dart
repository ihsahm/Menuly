import 'package:e_commerce/Contents/HomeContent/HomeList/Cafe/cafe_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class CafeMenu extends StatefulWidget {
  @override
  _CafeMenuState createState() => _CafeMenuState();
}

class _CafeMenuState extends State<CafeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  child: Text("Cakes"),
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
                  child: Text("Coffee"),
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
                  child: Text("IceCream"),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.orange,
                  child: Text("Juice and Smoothie"),
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
              'Cafe nearby',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          CafeList(),
        ],
      ),
    );
  }
}
