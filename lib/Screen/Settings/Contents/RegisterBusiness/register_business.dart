import 'dart:io';
import 'package:e_commerce/Screen/Settings/Contents/RegisterBusiness/licenseImage.dart';
import 'package:e_commerce/Screen/Settings/Contents/RegisterBusiness/registerForm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterBusiness extends StatefulWidget {
  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File image1;
  File file;
  String businessName;
  String phoneNumber;
  bool imageSelected = false;
  bool loading = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  final imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final _licenseData = Provider.of<LicenseImage>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Register a business',
          ),
          elevation: 0.5,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.clear,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              InkWell(
                onTap: () {
                  _licenseData.getImage().then((image) {
                    setState(() {
                      image1 = image;
                    });

                    if (image != null) {
                      _licenseData.imageAvailable = true;
                    }
                  });
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Card(
                    child: image1 == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Click here to add a photo of your license(የንግድ ፈቃድ)'),
                            ),
                          )
                        : Image.file(
                            image1,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              RegisterForm(),
            ]),
          ),
        ));
  }
}
