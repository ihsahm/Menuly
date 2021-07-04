import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class LicenseImage extends ChangeNotifier {
  File image;
  bool imageAvailable = false;
  double shopLatitude;
  double shopLongitude;
  String shopAddress;
  String placeName;

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    this.shopLatitude = _locationData.latitude;
    this.shopLongitude = _locationData.longitude;
    notifyListeners();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var _shopAdddress = _addresses.first;
    this.shopAddress = _shopAdddress.subLocality;
    this.placeName = _shopAdddress.featureName;
    notifyListeners();
    return shopAddress;
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    if (pickedFile != null) {
      this.image = File(pickedFile.path);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'No image selected');
      notifyListeners();
    }
    return this.image;
  }

  Future<void> saveBusinessData({
    String url,
    String businessName,
    String phoneNumber,
  }) {
    DocumentReference _license =
        FirebaseFirestore.instance.collection('Requests').doc(businessName);
    _license.set({
      'businessName': businessName,
      'phoneNumber': phoneNumber,
      'imageUrl': url,
      'address': '${this.placeName}:${this.shopAddress}',
      'location': GeoPoint(this.shopLatitude, this.shopLongitude),
    });
    return null;
  }
}
