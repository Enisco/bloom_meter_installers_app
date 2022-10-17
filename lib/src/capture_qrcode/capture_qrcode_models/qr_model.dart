// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bem_install_app/core/helpers/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:go_router/go_router.dart';

class ScanQRModel with ChangeNotifier {
  String _barcodeScanRes = '';

  String get barcodeScanRes => _barcodeScanRes;

  ScanQRModel();

  /// Decryption function
  List<String> decrypt(String stringToDecrypt) {
    String decryptedText = '';

    for (int i = 0; i < stringToDecrypt.length; i++) {
      String dec = String.fromCharCode(stringToDecrypt[i].codeUnitAt(0) - 10);
      decryptedText += dec;
    }
    print('decryptedText: $decryptedText');

    List<String> vals = decryptedText.split(',');
    return vals;
  }

  Future<void> scanQRcode(BuildContext context) async {
    try {
      _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print("qrcode ====> $_barcodeScanRes");

      /// Decrypt the QR code read
      List myVal = decrypt(_barcodeScanRes);

      // Save meter ID to prefs

      await SharedPrefs.saveStringValue(
          'qrCode Value', '${myVal[0]},${myVal[1]}');
      sleep(const Duration(milliseconds: 200));
      navigateToEnterPhoneNumberScreeen(context);
    } on PlatformException {
      _barcodeScanRes = '';
    } catch (e) {
      print("Error! Couldn't scan");
    }

    notifyListeners();
  }

  void navigateToEnterPhoneNumberScreeen(BuildContext context) {
    context.go('/enterPhoneNumberView');
  }

  void updateVals() {
    notifyListeners();
  }
}
