import 'package:e_commerce/Contents/HomeContent/HomeList/Shopping/Details/shopping_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class ShoppingDetails extends StatefulWidget {
  final name;
  final phone;

  final userlocationLatitude;
  final userlocationLongitude;
  final latitude;
  final image;
  final longitude;
  final type;

  const ShoppingDetails(
      {Key key,
      this.name,
      this.phone,
      this.latitude,
      this.longitude,
      this.type,
      this.image,
      this.userlocationLatitude,
      this.userlocationLongitude})
      : super(key: key);
  @override
  _ShoppingDetailsState createState() => _ShoppingDetailsState();
}

class _ShoppingDetailsState extends State<ShoppingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                /* title: Text(
                 widget.restaurantName,
               ),*/
                background: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://addisfortune.net/wp-content/uploads/2015/02/The-New-Face-of-Retail-Trade.jpg")),
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
        body: ShoppingContact(),
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
