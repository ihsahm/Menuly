import 'package:flutter/material.dart';

class DetailsContent extends StatefulWidget {
  @override
  _DetailsContentState createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Column(children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  "https://www.world-grain.com/ext/resources/Article-Images/2020/04/Barley-in-bag_Photo-Adobe-stock-E.jpg?1587393277",
                ),
              ),
            )
          ]),
          Container(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: Column(
              children: [
                Text(''' 	
	
Malting Barley Class A

Origin: USA/South America/Canada/Australia/Sellers Option
Moisture: 13% Max
Protein: 10% Min 11.5% Max
Germination Energy: 95% after 5 days
Full Barley: 90%
Below: 2.2 mm Max 3%
Purity of Variety: 95% Min
Foreign Variety: 1% Max
1000 Kernel Weight: 40 gr
HI Weight: Min 67 kg/h''')
              ],
            ),
          )
        ]));
  }
}
