import 'package:bem_install_app/src/enter_phone_no/enter_phone_no_model/enter_phone_no_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterPhoneNumberController {
  TextEditingController phoneNumberController = TextEditingController();
  EnterPhoneNumberController();

  String errorText(BuildContext context) {
    EnterPhoneNumberModel enterPhoneNoModel =
        Provider.of<EnterPhoneNumberModel>(context, listen: false);

    return enterPhoneNoModel.errorText;
  }

  void checkIfNumberIsValid(BuildContext context, String phoneNumber) {
    EnterPhoneNumberModel enterPhoneNoModel =
        Provider.of<EnterPhoneNumberModel>(context, listen: false);

    enterPhoneNoModel.checkIfNumberIsValid(context, phoneNumber);
  }
}
