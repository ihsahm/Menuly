import 'package:e_commerce/Contents/HomeContent/HomeList/Shopping/Content/shopping_content.dart';
import 'package:flutter/material.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Shops nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        /*     Wrap(
            runSpacing: 0.0,
            spacing: 2.0,
            children: [
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("All"),
                      onPressed: () {
                        val.getAllData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Supermarket"),
                      onPressed: () {
                        val.getCakeData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Minimarket"),
                      onPressed: () {
                        val.getCoffeeData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Shops"),
                      onPressed: () {
                        val.getIceCreamData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: CafeQuerying(),
              ),
              ]*/
        ShoppingList(),
      ],
    );
  }
}
