import 'package:flutter/material.dart';

class ParkingList extends StatefulWidget {
  @override
  _ParkingListState createState() => _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Parking ${index + 1}'),
          subtitle: Text('Distance: 1.2 km'),
          onTap: () {},
        );
      },
    );
  }
}
