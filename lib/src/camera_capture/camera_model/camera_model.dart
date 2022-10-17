// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:bem_install_app/src/homepage/homepage_views/homepage_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bem_install_app/core/helpers/sharedprefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class CameraCaptureModel with ChangeNotifier {
  CameraCaptureModel();

  File? imageFile;
  String? imageUrl;

  String currentLocation = '';

  /// Upload image from gallery
  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// Snap image with Camera
  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// get current location
  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('Position determined: $position');

    return position.toString();
  }

  Future<void> uploadData(BuildContext context) async {
    String savedQrCode = await SharedPrefs.getSavedString('qrCode Value');
    List<String> vals = savedQrCode.split(',');
    String meterId = vals[0];
    String simInMeter = vals[1];

    String phoneNumber = await SharedPrefs.getSavedString('Phone number');
    String currentLocation = await _determinePosition();

    print('Position coordinates: $currentLocation');

    /// Upload image to cloud storage
    final firebaseStorage = FirebaseStorage.instance;
    var file = File(imageFile!.path);
    var snapshot = await firebaseStorage
        .ref()
        .child('serl/$meterId@$phoneNumber')
        .putFile(file)
        .whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Great! Image uploaded',
                style: TextStyle(color: Colors.amber),
              ),
              backgroundColor: Colors.green[800],
              action: SnackBarAction(
                label: '',
                onPressed: () {
                  // Do nothing!
                },
              ),
            ),
          ),
        );

    /// Generate download
    var downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl = downloadUrl;
    notifyListeners();
    DateTime now =  DateTime.now();

    /// Map data
    Map<String, dynamic> data = <String, dynamic>{
      "Meter ID": meterId,
      "Time of installation": now.toString(),
      "Sim inside Meter": simInMeter,
      "Location address": currentLocation,
      "Image link": imageUrl
    };

    print('Data to be uploaded: $data');

    /// Upload data to firestore
    await FirebaseFirestore.instance
        .collection("serl_meters")
        .doc(phoneNumber)
        .set(data)
        .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Success! Data recorded',
                  style: TextStyle(color: Colors.white70),
                ),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: '',
                  onPressed: () {
                    // Do nothing!
                  },
                ),
              ),
            ))
        .onError((error, stackTrace) => null);

    context.go('/');
  }

  /// Update values
  void updateVals() {
    notifyListeners();
  }

  // Future<bool> checkIfDataExists(String phoneNumber) async {
  //   bool dataExists;
  //   final docSnapShot = await FirebaseFirestore.instance
  //       .collection("serl_meters")
  //       .doc(phoneNumber)
  //       .get();

  //   if (docSnapShot.exists) {
  //     dataExists = true;
  //     _returnedMeterID = docSnapShot.data()!["Meter ID"].toString();
  //     print('Returned Meter ID: $_returnedMeterID');
  //   } else {
  //     dataExists = false;
  //   }

  //   return dataExists;
  // }
}
