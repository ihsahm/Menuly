import 'package:flutter/material.dart';

class ShoppingContact extends StatefulWidget {
  final phone;
  final type;
  final name;

  const ShoppingContact({Key key, this.phone, this.type, this.name})
      : super(key: key);
  @override
  _ShoppingContactState createState() => _ShoppingContactState();
}

class _ShoppingContactState extends State<ShoppingContact> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '''Sheraton Hotels and Resorts is an international hotel chain owned by Marriott International. As of June 30, 2020, Sheraton operates 446 hotels with 155,617 rooms globally, including locations in North America, Africa, Asia Pacific, Central and South America, Europe, the Middle East and the Caribbean, in addition to 84 hotels with 23,092 rooms in the pipeline''',
                style: TextStyle(color: Colors.blueGrey))),
        Divider(
          endIndent: 30,
          indent: 30,
        ),
        ListTile(
          title: Text(widget.name),
          leading: Icon(
            Icons.business_outlined,
            color: Colors.red[900],
          ),
        ),
        ListTile(
          title: Text(widget.type),
          leading: Icon(Icons.info_outline, color: Colors.blue),
        ),
        ListTile(
          title: Text(widget.phone),
          leading: Icon(
            Icons.phone_android_outlined,
            color: Colors.green[800],
          ),
        ),
      ],
    );
  }
}
