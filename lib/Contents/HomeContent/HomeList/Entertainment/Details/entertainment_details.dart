import 'package:cached_network_image/cached_network_image.dart';
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
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  floating: false,
                  snap: false,
                  backgroundColor: Colors.white,
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: Stack(
                    children: [
                      Positioned.fill(
                          child: CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ))
                    ],
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
                  title: Text('Name'),
                  subtitle: Text(widget.name),
                  leading: Icon(
                    Icons.business_outlined,
                    color: Colors.red[900],
                  ),
                ),
                ListTile(
                  title: Text('Phone number'),
                  subtitle: Text(widget.phone),
                  leading: Icon(
                    Icons.phone,
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
        child: TextButton.icon(
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
        ),
      ),
    );
  }
}
