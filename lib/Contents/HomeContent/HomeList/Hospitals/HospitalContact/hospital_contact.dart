import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalContact extends StatefulWidget {
  final phone;
  final instagram;
  final type;
  final facebook;
  final email;
  final info;

  const HospitalContact(
      {Key key,
      this.phone,
      this.instagram,
      this.facebook,
      this.email,
      this.info,
      this.type})
      : super(key: key);
  @override
  _HospitalContactState createState() => _HospitalContactState();
}

class _HospitalContactState extends State<HospitalContact> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.info,
                          style: TextStyle(color: Colors.blueGrey))),
                  Divider(
                    endIndent: 30,
                    indent: 30,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    title: Text('Phone number'),
                    subtitle: Text(widget.phone),
                    onTap: () {
                      launch('tel:${widget.phone}');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                    title: Text('Type'),
                    subtitle: Text(widget.type),
                    onTap: () {},
                  ),
                  /*  ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: Colors.red[700],
                    ),
                    title: Text(widget.email),
                    onTap: () {
                      launch('mailto: ${widget.email}');
                    },
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
