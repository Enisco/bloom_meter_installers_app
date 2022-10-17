import 'package:bem_install_app/core/helpers/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterPhoneNumberModel with ChangeNotifier {
  EnterPhoneNumberModel();

  String _errorText = '';
  String get errorText => _errorText;

  void checkIfNumberIsValid(BuildContext context, String phoneNumber) {
    if (phoneNumber.length == 11) {
      print('Phone number $phoneNumber is valid.');
      _errorText = '';
      SharedPrefs.saveStringValue('Phone number', phoneNumber);
      goToCameraScreen(context);
    } else {
      print('Phone number $phoneNumber is INVALID!');
      _errorText = 'Invalid number! Kindly recheck';
    }
    notifyListeners();
  }

  void goToCameraScreen(BuildContext context) {
    context.go('/cameraCaptureScreen');
  }

  void updateVals() {
    notifyListeners();
  }
}
