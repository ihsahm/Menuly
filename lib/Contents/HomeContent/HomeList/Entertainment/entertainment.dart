import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/Content/entertainment_list.dart';
import 'package:flutter/material.dart';

class Entertainment extends StatefulWidget {
  @override
  _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Entertainment nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        EntertainmentList(),
      ],
    );
  }
}
