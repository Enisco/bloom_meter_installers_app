import 'package:bem_install_app/src/homepage/homepage_models/homepage_model.dart';
import 'package:flutter/material.dart';

class HomepageController {
  void goToScanQRcode(BuildContext context) {
    HomepageModel.goToScanQRcodeScreen(context);
  }
}
