import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelContact extends StatefulWidget {
  final phone;
  final instagram;
  final facebook;
  final email;
  final info;

  const HotelContact(
      {Key key,
      this.phone,
      this.instagram,
      this.facebook,
      this.email,
      this.info})
      : super(key: key);
  // final
  @override
  _HotelContactState createState() => _HotelContactState();
}

class _HotelContactState extends State<HotelContact> {
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
                    title: Text(widget.phone),
                    onTap: () {
                      launch('tel:${widget.phone}');
                    },
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
                  ListTile(
                    leading:
                        Icon(Entypo.facebook_squared, color: Colors.blue[700]),
                    title: Text('Like us on facebook'),
                    onTap: () {
                      launch('url: ${widget.facebook}');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(FontAwesome5.instagram, color: Colors.pink[300]),
                    title: Text('Follow us on instagram'),
                    onTap: () {
                      launch('url:${widget.instagram}');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
