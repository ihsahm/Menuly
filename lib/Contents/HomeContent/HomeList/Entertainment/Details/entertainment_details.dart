import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EntertainmentDetails extends StatefulWidget {
  final image;
  final name;
  final info;
  final phone;
  final latitude;
  final userlocationLatitude;
  final userlocationLongitude;
  final longitude;
  const EntertainmentDetails(
      {Key key,
      this.image,
      this.name,
      this.phone,
      this.latitude,
      this.userlocationLatitude,
      this.userlocationLongitude,
      this.longitude,
      this.info})
      : super(key: key);
  @override
  _EntertainmentDetailsState createState() => _EntertainmentDetailsState();
}

class _EntertainmentDetailsState extends State<EntertainmentDetails> {
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
                        // borderRadius: BorderRadius.circular(50),
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
                  backgroundColor: Colors.blueGrey,
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    /* title: Text(
                      widget.restaurantName,
                    ),*/
                    background: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.image)),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(-2, -1),
                                blurRadius: 5),
                          ]),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                stops: [
                                  0.1,
                                  0.9
                                ],
                                colors: [
                                  Colors.black.withOpacity(.8),
                                  Colors.black.withOpacity(.1)
                                ])),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
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
                  title: Text(widget.name),
                  leading: Icon(
                    Icons.business_outlined,
                    color: Colors.red[900],
                  ),
                ),
                ListTile(
                  title: Text(widget.phone),
                  leading: Icon(
                    Icons.phone_android_outlined,
                    color: Colors.green[800],
                  ),
                ),
                Divider(
                  endIndent: 20,
                  indent: 20,
                ),
              ],
            )),
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
