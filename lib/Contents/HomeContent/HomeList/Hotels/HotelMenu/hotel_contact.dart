import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelContact extends StatefulWidget {
  final phone;
  final instagram;
  final facebook;
  final rating;
  final email;
  final info;

  const HotelContact(
      {Key key,
      this.phone,
      this.instagram,
      this.facebook,
      this.email,
      this.info,
      this.rating})
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
                    title: Text('Phone'),
                    subtitle: Text(widget.phone),
                    onTap: () {
                      launch('tel:${widget.phone}');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    title: Text('Rating'),
                    subtitle: RatingBarIndicator(
                      rating: widget.rating.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                  ListTile(
                    leading: Icon(FontAwesome.internet_explorer,
                        color: Colors.blue[700]),
                    title: Text('Visit our website'),
                    onTap: () {
                      //launch('url: ${widget.website}').toString();
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
