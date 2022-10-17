import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_models/qr_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanQRController {
  TextEditingController meterIdController = TextEditingController();
  ScanQRController();

  void scanQRcode(BuildContext context) {
    ScanQRModel homepageModel =
        Provider.of<ScanQRModel>(context, listen: false);

    homepageModel.scanQRcode(context);
  }
}
