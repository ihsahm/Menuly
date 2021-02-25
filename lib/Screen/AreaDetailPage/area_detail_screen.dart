import 'package:e_commerce/Contents/HomeContent/Details/Menu/food_menu.dart';
import 'package:e_commerce/Contents/HomeContent/Details/area_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class AreaDetailScreen extends StatefulWidget {
  final restaurantName;
  final restaurantMenu;
  final restaurantType;
  final restaurantImage;
  final restaurantPhone;
  final restaurantEmail;
  final restaurantFacebook;
  final restaurantInstagram;

  const AreaDetailScreen(
      {Key key,
      this.restaurantName,
      this.restaurantMenu,
      this.restaurantType,
      this.restaurantPhone,
      this.restaurantEmail,
      this.restaurantFacebook,
      this.restaurantInstagram,
      this.restaurantImage});
  @override
  _AreaDetailScreenState createState() => _AreaDetailScreenState();
}

class _AreaDetailScreenState extends State<AreaDetailScreen> {
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
          onPressed: () {},
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
