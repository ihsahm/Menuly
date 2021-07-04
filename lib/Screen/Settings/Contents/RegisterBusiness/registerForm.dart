import 'dart:io';

import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Screen/Settings/Contents/RegisterBusiness/licenseImage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String phoneNumber;
  String businessName;
  Future<String> uploadFile(filePath) async {
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage.ref('license/${_nameTextController.text}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String downloadURL = await _storage
        .ref('license/${_nameTextController.text}')
        .getDownloadURL();
    return downloadURL;
  }

  bool _isLoading = false;
  // Future<String> uploadItemImage(file) async {
  //   final StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child("license");

  //   StorageUploadTask task = storageReference
  //       .child("${DateTime.now().millisecondsSinceEpoch}")
  //       .putFile(image1);
  //   StorageTaskSnapshot taskSnapshot = await task.onComplete;
  //   String downloadurl = await taskSnapshot.ref.getDownloadURL();
  //   return downloadurl;
  // }

  final _formKey = GlobalKey<FormState>();
  var _addressTextController = TextEditingController();
  var _nameTextController = TextEditingController();
  var _phoneTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _licenseData = Provider.of<LicenseImage>(context);
    return _isLoading
        ? CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _nameTextController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter business name';
                      }
                      setState(() {
                        _nameTextController.text = value;
                      });
                      setState(() {
                        businessName = value;
                      });
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: 'Business name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business_center)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _addressTextController,
                    maxLines: 6,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please press navigation button';
                      }
                      if (_licenseData.shopLatitude == null) {
                        return 'Please press navigation button';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: 'Business area',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.location_searching),
                          onPressed: () {
                            _licenseData.getCurrentAddress().then((address) {
                              if (address != null) {
                                _addressTextController.text =
                                    '${_licenseData.placeName}\n${_licenseData.shopAddress}';
                              } else {
                                return Fluttertoast.showToast(msg: 'Error');
                              }
                            });
                          },
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14.0, top: 2),
                  child: TextFormField(
                    controller: _phoneTextController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter phone number';
                      }

                      setState(() {
                        _phoneTextController.text = value;
                      });

                      setState(() {
                        phoneNumber = value;
                      });
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_android_outlined)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text(
                          'Send',
                          style: TextStyle(color: ColorsConst.white),
                        ),
                        onPressed: () {
                          if (_licenseData.imageAvailable == true) {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing data')));
                              uploadFile(_licenseData.image.path).then((url) {
                                if (url != null) {
                                  _licenseData.saveBusinessData(
                                    url: url,
                                    businessName: businessName,
                                    phoneNumber: phoneNumber,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Failed to upload image');
                                }
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      'Error while registering try again later');
                            }
                            // uploadImageandSaveItem();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Image is needed')));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                        )),
                  ),
                ),
              ],
            ),
          );
  }
}
