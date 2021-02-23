import 'package:flutter/material.dart';

class RegisterBusiness extends StatefulWidget {
  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register a business',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
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
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Business name'),
            ),
            OutlineButton.icon(
              icon: Icon(Icons.image),
              label: Text('Add a photo of your business license(የንግድ ፈቃድ)'),
              onPressed: () {},
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Phone number'),
            ),
            RaisedButton(
              child: Text(
                'Send',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
