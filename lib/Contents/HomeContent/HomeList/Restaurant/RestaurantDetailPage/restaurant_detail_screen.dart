import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/Details/Menu/restaurant_menu.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/Details/restaurant_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AreaDetailScreen extends StatefulWidget {
  final restaurantName;
  final restaurantMenu;
  final restaurantType;
  final restaurantRating;
  final restaurantImage;
  final restaurantPhone;
  final restaurantEmail;
  final restaurantFacebook;
  final restaurantInstagram;
  final restaurantLatitude;
  final restaurantLongtitude;
  final userlocationLatitude;
  final userlocationLongtiude;

  const AreaDetailScreen(
      {Key key,
      this.restaurantName,
      this.restaurantMenu,
      this.restaurantType,
      this.restaurantPhone,
      this.restaurantEmail,
      this.restaurantFacebook,
      this.restaurantInstagram,
      this.restaurantImage,
      this.restaurantLatitude,
      this.restaurantLongtitude,
      this.userlocationLatitude,
      this.userlocationLongtiude,
      this.restaurantRating});
  @override
  _AreaDetailScreenState createState() => _AreaDetailScreenState();
}

class _AreaDetailScreenState extends State<AreaDetailScreen> {
  Future<void> _launchInApp() async {
    var url =
        "https://www.google.com/maps/dir/${widget.userlocationLatitude},${widget.userlocationLongtiude}/${widget.restaurantLatitude},${widget.restaurantLongtitude}/@8.9817088,38.7284248,15z";
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                //  actions: [
                //   Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         // borderRadius: BorderRadius.circular(50),
                //         color: Colors.grey[600],
                //       ),
                //       child: IconButton(
                //         icon: Icon(Icons.favorite),
                //         color: Colors.white,
                //         onPressed: () {},
                //       ),
                //     ),
                //   )
                // ],
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
                        imageUrl: widget.restaurantImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Menu'),
                    ),
                    Tab(
                      child: Text('Info'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            FoodMenu(
              menuList: widget.restaurantMenu,
            ),
            AreaDetails(
              image: widget.restaurantImage,
              rating: widget.restaurantRating,
              menuDoc: widget.restaurantMenu,
              facebook: widget.restaurantFacebook,
              instagram: widget.restaurantInstagram,
              phone: widget.restaurantPhone,
              email: widget.restaurantEmail,
              type: widget.restaurantType,
            ),
          ]),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: TextButton.icon(
      //     icon: Icon(
      //       FontAwesome.direction,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       _launchInApp();
      //     },
      //     label: Text(
      //       'Get direction',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      //     ),
      //   ),
      // ),
    );
  }
}
