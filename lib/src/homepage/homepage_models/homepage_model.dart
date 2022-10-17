import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_view/qr_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomepageModel {
  HomepageModel();

  static void goToScanQRcodeScreen(BuildContext context) {
    context.push('/scanQRView');
  }
}
