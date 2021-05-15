import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screen/Shared/loadingScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterBusiness extends StatefulWidget {
  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  final formKey = GlobalKey<FormState>();
  File image1;
  File file;
  String restaurantName;
  String phoneNumber;
  bool loading = false;

  final imagePicker = ImagePicker();
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
          child: loading
              ? LoadingScreen()
              : Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      OutlineButton(
                          onPressed: () {
                            getImage();
                          },
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          child: (image1 != null)
                              ? Container(
                                  height: 200,
                                  child: Image.file(
                                    image1,
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 26, 8.0, 26),
                                  child: Text(
                                    'Click to add a photo of \n your license(የንግድ ፈቃድ)',
                                  ),
                                )),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          this.restaurantName = value;
                        },
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: 'Business name',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          this.phoneNumber = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Phone number',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            uploadImageandSaveItem();
                          },
                          color: Colors.blue,
                        ),
                      )
                    ],
                  )),
        ));
  }

  Future getImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image1 = File(image.path);
    });
  }

  void validateAndUpload() async {
    if (formKey.currentState.validate()) {
      setState(() => loading = true);
      if (image1 != null) {
        if (restaurantName.isNotEmpty) {
          String imageUrl1;

          final StorageReference storage =
              FirebaseStorage.instance.ref().child("licenserequest");
          final String picture =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask uploadtask = storage.child(picture).putFile(image1);
          StorageTaskSnapshot taskSnapshot =
              await uploadtask.onComplete.then((snapshot) async {
            imageUrl1 = await snapshot.ref.getDownloadURL();
            final itemsRef =
                FirebaseFirestore.instance.collection('Registration request');

            itemsRef.doc(restaurantName).set(
              {
                'name': restaurantName,
                'phone': phoneNumber,
                'image': imageUrl1,
              },
            );

            formKey.currentState.reset();

            setState(() => loading = false);
          });
        } else {
          setState(() => loading = false);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Unable to register please try later'),
                );
              });
        }
      } else {
        setState(() => loading = false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter phone'),
              );
            });
      }
    }
  }

  Future<String> uploadImageandSaveItem() async {
    String imageDownloadUrl = await uploadItemImage(image1);
    if (formKey.currentState.validate()) {
      setState(() => loading = true);
      if (restaurantName.isNotEmpty) {
        if (image1 != null) {
          saveItem(imageDownloadUrl);
          formKey.currentState.reset();
          setState(() => loading = false);
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    content: const Text(
                        'Registration requested please wait for confirmation'),
                    actions: [
                      FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Unable to register please try later'),
                );
              });
          setState(() => loading = false);
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter an image'),
              );
            });
        setState(() => loading = false);
        // Fluttertoast.showToast(msg: 'Enter a price');
      }
    }
  }

  Future<String> uploadItemImage(file) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("licenselist");

    StorageUploadTask task = storageReference
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image1);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  saveItem(imageDownloadUrl) {
    var id = Uuid();
    String productId = id.v1();
  }
}
