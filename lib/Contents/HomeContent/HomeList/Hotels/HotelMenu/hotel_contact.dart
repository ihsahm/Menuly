import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelContact extends StatefulWidget {
  final phone;
  final instagram;
  final facebook;
  final email;

  const HotelContact(
      {Key key, this.phone, this.instagram, this.facebook, this.email})
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
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.info,
                  //     color: Colors.blue[900],
                  //   ),
                  //   title: Text(widget.type),
                  // ),
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
                    leading: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    title: Text(widget.phone),
                    onTap: () {
                      launch('tel:${widget.phone}');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: Colors.red[700],
                    ),
                    title: Text(widget.email),
                    onTap: () {
                      launch('mailto: ${widget.email}');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Entypo.facebook_squared, color: Colors.blue[700]),
                    title: Text(widget.facebook),
                    onTap: () {
                      launch('url: ${widget.facebook}');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(FontAwesome5.instagram, color: Colors.pink[300]),
                    title: Text(widget.instagram),
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
