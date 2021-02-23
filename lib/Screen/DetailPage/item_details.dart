import 'package:e_commerce/Contents/DetailsContent/details_content.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      body: DetailsContent(),
      bottomNavigationBar: Container(
        height: 50,
        child: RaisedButton(
          child: Text(
            'Order',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {},
          color: Colors.blue,
        ),
      ),
    );
  }
}
