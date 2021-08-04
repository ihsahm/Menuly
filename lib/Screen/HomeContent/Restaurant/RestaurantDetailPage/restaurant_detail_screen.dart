import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Consts/icons.dart';
import 'package:e_commerce/Screen/HomeContent/Restaurant/RestaurantDetailPage/Details/Contact/restaurant_contact.dart';
import 'package:e_commerce/Screen/HomeContent/Restaurant/RestaurantDetailPage/Details/Menu/restaurant_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailScreen extends StatefulWidget {
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

  const RestaurantDetailScreen(
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
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
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
                //         color: ColorsConst.white,
                //         onPressed: () {},
                //       ),
                //     ),
                //   )
                // ],
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      IconsData.arrowBack,
                      color: ColorsConst.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                floating: false,
                snap: false,
                backgroundColor: ColorsConst.white,
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
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: ColorsConst.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Info',
                        style: TextStyle(
                          color: ColorsConst.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            FoodMenu(
              menuList:
                  widget.restaurantMenu != null ? widget.restaurantMenu : '',
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
      //       color: ColorsConst.white,
      //     ),
      //     onPressed: () {
      //       _launchInApp();
      //     },
      //     label: Text(
      //       'Get direction',
      //       style: TextStyle(color: ColorsConst.white),
      //     ),
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      //     ),
      //   ),
      // ),
    );
  }
}
