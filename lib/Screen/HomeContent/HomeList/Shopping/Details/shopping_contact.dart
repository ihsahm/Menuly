import 'package:flutter/material.dart';

class ShoppingContact extends StatefulWidget {
  final phone;
  final type;
  final name;
  final info;

  const ShoppingContact({Key key, this.phone, this.type, this.name, this.info})
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
            child: Text(widget.info, style: TextStyle(color: Colors.blueGrey))),
        Divider(
          endIndent: 30,
          indent: 30,
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(widget.name),
          leading: Icon(
            Icons.business_outlined,
            color: Colors.red[900],
          ),
        ),
        ListTile(
          title: Text('Type'),
          subtitle: Text(widget.type),
          leading: Icon(Icons.info, color: Colors.blue),
        ),
        ListTile(
          title: Text('Phone number'),
          subtitle: Text(widget.phone),
          leading: Icon(
            Icons.phone,
            color: Colors.green[800],
          ),
        ),
      ],
    );
  }
}
