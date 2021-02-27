import 'package:e_commerce/Contents/HomeContent/Details/Menu/food_menu.dart';
import 'package:e_commerce/Contents/HomeContent/Details/area_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AreaDetailScreen extends StatefulWidget {
  final restaurantName;
  final restaurantMenu;
  final restaurantType;
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
      this.userlocationLongtiude});
  @override
  _AreaDetailScreenState createState() => _AreaDetailScreenState();
}

class _AreaDetailScreenState extends State<AreaDetailScreen> {
  Future<void> _launchInApp() async {
    var url =
        "https://www.google.com/maps/dir/${widget.userlocationLatitude},${widget.userlocationLongtiude}/${widget.restaurantLatitude},${widget.restaurantLongtitude}/@8.9937498,38.7062355,13z/data=!4m11!4m10!1m1!4e1!1m5!1m1!1s0x164b8f10bc299b27:0xf9ac2c481a9b40d9!2m2!1d38.7625901!2d9.0381429!3e2!5i1";
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                floating: false,
                snap: false,
                backgroundColor: Colors.blueGrey,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.restaurantName,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  background: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.restaurantImage)),
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
