import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Screen/Settings/Contents/RegisterBusiness/register_business.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsContent extends StatefulWidget {
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SettingsList()],
    );
  }
}

class SettingsList extends StatefulWidget {
  const SettingsList({Key key}) : super(key: key);

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return ListView(
      shrinkWrap: true,
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
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.bug_report_outlined),
          title: const Text('Report a bug or an issue'),
          onTap: () {
            launch('mailto:metrix.app11@gmail.com');
          },
        ),
        ListTile(
          leading: const Icon(Icons.star_outline),
          title: const Text('Rate us on playstore'),
          onTap: () {},
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
        ListTileSwitch(
          value: themeChange.darkTheme,
          onChanged: (value) {
            setState(() {
              themeChange.darkTheme = value;
            });
          },
          visualDensity: VisualDensity.comfortable,
          leading: const Icon(FontAwesome.moon),
          title: const Text('Dark mode'),
          switchType: SwitchType.cupertino,
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.copyright),
          title: const Text('Terms of use'),
          onTap: () {
            launch("https://metrixapp11.wixsite.com/metrix/terms-of-use");
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: const Text('Privacy policy'),
          onTap: () {
            launch("https://metrixapp11.wixsite.com/metrix/privacy-policy");
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About us'),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('About us'),
                      content: Wrap(
                        children: [
                          const Text('Menuly 1.0.0'),
                          Row(
                            children: [
                              Text('Copyright '),
                              Icon(
                                Icons.copyright_outlined,
                                color: Colors.grey[400],
                                size: 16,
                              ),
                              Text("Metrix IO"),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'Okay',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
          },
        ),
      ],
    );
  }
}
