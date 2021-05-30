import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screen/Shared/loadingScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    OutlinedButton(
                        onPressed: () {
                          getImage();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                        child: (image1 != null)
                            ? Container(
                                height: 100,
                                child: Image.file(
                                  image1,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.fromLTRB(8.0, 26, 8.0, 26),
                                child: TextButton(
                                  child: Text(
                                      'First click to add a photo of \n your license(የንግድ ፈቃድ)'),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              )),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        controller: nameController,
                        onChanged: (value) {
                          this.businessName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter business name';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: 'Business name',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        controller: phoneController,
                        onChanged: (value) {
                          this.phoneNumber = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Phone number',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            uploadImageandSaveItem();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.greenAccent[400]),
                          )),
                    ),
                  ]),
          ),
        ));
  }

  Future getImage() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        image1 = File(image.path);
        imageSelected = true;
      });
    } else {
      return Fluttertoast.showToast(msg: 'Please select an image');
    }
  }

  // ignore: missing_return
  Future<String> uploadImageandSaveItem() async {
    String imageDownloadUrl = await uploadItemImage(image1);
    if (formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      if (image1 != null) {
        if (businessName.isNotEmpty) {
          if (phoneNumber.isNotEmpty) {
            saveItem(imageDownloadUrl);
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Posted'),
                      content: const Text('Item uploaded succesfully'),
                      actions: [
                        TextButton(
                            child: Text('Okay'),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ));
          }
        } else {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: 'Please check and try again');
        }
      } else {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(msg: 'Please check and try again');
      }
    }
  }

  Future<String> uploadItemImage(file) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("license");

    StorageUploadTask task = storageReference
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image1);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  saveItem(imageDownloadUrl) {
    // var id = Uuid();
    // String productId = id.v1();
    final itemsRef = FirebaseFirestore.instance.collection('Requests');

    itemsRef.doc(businessName).set(
      {
        'name': businessName,
        'phone': phoneNumber,
        'image': imageDownloadUrl,
      },
    );

    setState(() {
      loading = false;
      formKey.currentState.reset();
    });
  }
}
