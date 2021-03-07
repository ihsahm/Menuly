import 'package:e_commerce/Contents/Settings/RegisterBusiness/register_business.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsContent extends StatefulWidget {
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.edit_outlined),
          title: Text('Register a business'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => RegisterBusiness()));
          },
        ),
        ListTile(
          leading: Icon(Icons.bug_report_outlined),
          title: Text('Report a bug or an issue'),
          onTap: () {
            launch('mailto:ihsahm@gmail.com');
          },
        ),
        ListTile(
          leading: Icon(Icons.headset_mic_outlined),
          title: Text('Contact support'),
          onTap: () {
            launch(('tel:+251907268733'));
          },
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
        ListTile(
          leading: Icon(Icons.star_outline),
          title: Text('Rate us on playstore'),
          onTap: () {
            
          },
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
        ListTile(
          leading: Icon(Icons.policy_outlined),
          title: Text('Privacy policy'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About us'),
          onTap: () {
            showAboutDialog(
              context: context,
              
            );
          },
        ),
      ],
    );
  }
}
