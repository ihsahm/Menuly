import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sheraton Addis',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Image.network(
              "https://www.jacadatravel.com/wp-content/uploads/2017/06/addis-sheraton-exterior.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Room details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          /*  ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text('Deluxe room'),
                    subtitle: Text('Price: 200 usd'));
              }),*/
          ListTile(
              leading: Icon(Icons.hotel),
              title: Text('Deluxe room'),
              subtitle: Text('Price: 200 usd')),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300]),
                child: FlatButton.icon(
                  icon: Icon(Icons.call),
                  label: Text('Call'),
                  onPressed: () {},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300]),
                child: FlatButton.icon(
                  icon: Icon(Icons.message),
                  label: Text('Message'),
                  onPressed: () {},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300]),
                child: FlatButton.icon(
                  icon: Icon(Icons.report_rounded),
                  label: Text('Report'),
                  onPressed: () {},
                ),
              ),
            ],
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Contact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
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
                  ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    title: Text('0114192926'),
                    onTap: () {
                      //  launch('tel:${widget.phone}');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: Colors.red[700],
                    ),
                    title: Text('sheraton@gmail.com'),
                    onTap: () {
                      //  launch('mailto: ${widget.email}');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Entypo.facebook_squared, color: Colors.blue[700]),
                    title: Text('Like us on facebook'),
                    onTap: () {
                      //  launch('url: ${widget.facebook}');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(FontAwesome5.instagram, color: Colors.pink[300]),
                    title: Text('Follow us on instagram'),
                    onTap: () {
                      //launch('url:${widget.instagram}');
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
