import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/hotel_list.dart';
import 'package:flutter/material.dart';

class Hotel extends StatefulWidget {
  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // Wrap(
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      //       child: ElevatedButton(
      //         textColor: Colors.white,
      //         color: Colors.orange,
      //         child: Text("< 200 br"),
      //         onPressed: () {},
      //         shape: new RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      //       child: ElevatedButton(
      //         textColor: Colors.white,
      //         color: Colors.orange,
      //         child: Text("250 br-450 br"),
      //         onPressed: () {},
      //         shape: new RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      //       child: ElevatedButton(
      //         textColor: Colors.white,
      //         color: Colors.orange,
      //         child: Text("500 br-1000 br"),
      //         onPressed: () {},
      //         shape: new RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 5.0, right: 5.0),
      //       child: ElevatedButton(
      //         textColor: Colors.white,
      //         color: Colors.orange,
      //         child: Text("1000 br-5000 br"),
      //         onPressed: () {},
      //         shape: new RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 5.0, right: 5.0),
      //       child: ElevatedButton(
      //         textColor: Colors.white,
      //         color: Colors.orange,
      //         child: Text("> 5000 br"),
      //         onPressed: () {},
      //         shape: new RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Hotels nearby',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      HotelList(),
    ]);
  }
}
