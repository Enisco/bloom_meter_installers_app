import 'package:bem_install_app/src/camera_capture/camera_model/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraCaptureController {
  TextEditingController phoneNumberController = TextEditingController();
  CameraCaptureController();

  void uploadfromGallery(BuildContext context) {
    CameraCaptureModel cameraCaptureModel =
        Provider.of<CameraCaptureModel>(context, listen: false);

    cameraCaptureModel.getFromGallery();
  }

  void captureFromCamera(BuildContext context) {
    CameraCaptureModel cameraCaptureModel =
        Provider.of<CameraCaptureModel>(context, listen: false);

    cameraCaptureModel.getFromCamera();
  }

  void uploadDataToFB(BuildContext context) {
    CameraCaptureModel cameraCaptureModel =
        Provider.of<CameraCaptureModel>(context, listen: false);

    cameraCaptureModel.uploadData(
        context);
  }

  void updateVals(BuildContext context) {
    CameraCaptureModel cameraCaptureModel =
        Provider.of<CameraCaptureModel>(context, listen: false);

    cameraCaptureModel.updateVals();
  }
}
