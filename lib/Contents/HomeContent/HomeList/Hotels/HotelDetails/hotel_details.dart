import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_contact.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_room.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetails extends StatefulWidget {
  final name;
  final phone;
  final instagram;
  final image;
  final facebook;
  final room;
  final latitude;
  final userlocationLatitude;
  final userlocationLongitude;
  final longitude;
  final info;
  final email;

  const HotelDetails(
      {Key key,
      this.name,
      this.phone,
      this.instagram,
      this.facebook,
      this.room,
      this.latitude,
      this.longitude,
      this.email,
      this.userlocationLatitude,
      this.userlocationLongitude,
      this.image,
      this.info})
      : super(key: key);
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  Future<void> _launchInApp() async {
    var url =
        "https://www.google.com/maps/dir/${widget.userlocationLatitude},${widget.userlocationLongitude}/${widget.latitude},${widget.longitude}/@8.9817088,38.7284248,15z";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[600],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  floating: false,
                  snap: false,
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SizedBox(
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ),
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     image: DecorationImage(
                      //         fit: BoxFit.cover,
                      //         image: ),
                      //     borderRadius: BorderRadius.circular(5),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           color: Colors.grey[300],
                      //           offset: Offset(-2, -1),
                      //           blurRadius: 5),
                      //     ]),
                      // child: Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       gradient: LinearGradient(
                      //           begin: Alignment.bottomRight,
                      //           stops: [
                      //             0.1,
                      //             0.9
                      //           ],
                      //           colors: [
                      //             Colors.black.withOpacity(.8),
                      //             Colors.black.withOpacity(.1)
                      //           ])),
                      // ),
                    ),
                  ),
                  /*       bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Rooms'),
                    ),
                    Tab(
                      child: Text('Info'),
                    ),
                  ],
                ),*/
                ),
              ];
            },
            body: // TabBarView(children: [
                /* RoomDetails(
              room: widget.room,
              //  price: widget.,
            ),*/
                HotelContact(
              facebook: widget.facebook,
              instagram: widget.instagram,
              phone: widget.phone,
              email: widget.email,
              info: widget.info,
            ),
          )
          //  ]),
          // ),
          ),
      bottomNavigationBar: Container(
        height: 50,
        child: FlatButton.icon(
          icon: Icon(
            FontAwesome.direction,
            color: Colors.white,
          ),
          onPressed: () {
            _launchInApp();
          },
          label: Text(
            'Get direction',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
