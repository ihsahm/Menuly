import 'package:flutter/material.dart';

class RoomDetails extends StatefulWidget {
  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      child: Column(children: [
        ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  indent: 30,
                  endIndent: 30,
                ),
            shrinkWrap: true,
            itemCount: 8,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  onTap: () {},
                  leading: Icon(Icons.hotel),
                  title: Text('Deluxe room'),
                  subtitle: Text('Price: 200 usd'));
            }),
      ]),
    );
  }
}
