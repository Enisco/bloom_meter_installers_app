import 'package:bem_install_app/core/helpers/sharedprefs.dart';
import 'package:bem_install_app/core/widgets/custom_textfield.dart';
import 'package:bem_install_app/src/enter_phone_no/enter_phone_no_controller/enter_phone_no_controller.dart';
import 'package:bem_install_app/src/enter_phone_no/enter_phone_no_model/enter_phone_no_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterPhoneNumberView extends StatefulWidget {
  const EnterPhoneNumberView({super.key});

  @override
  State<EnterPhoneNumberView> createState() => _EnterPhoneNumberViewState();
}

class _EnterPhoneNumberViewState extends State<EnterPhoneNumberView> {
  final EnterPhoneNumberController _controller = EnterPhoneNumberController();
  String? readMeterID;
  late Future<String> _value;
  bool showErrorText = false;

  @override
  void initState() {
    super.initState();
    _value = retrieveMeterID();

    print('readMeterID again: $readMeterID');
  }

  Future<String> retrieveMeterID() async {
    String qrCodeValue = await SharedPrefs.getSavedString('qrCode Value');
    print('qrCode Value: $qrCodeValue');
    return qrCodeValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<EnterPhoneNumberModel>(
      create: (context) => EnterPhoneNumberModel(),
      child: Consumer<EnterPhoneNumberModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Enter Phone Number'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(size.width / 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height / 5),
                  FutureBuilder(
                    future: _value,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Visibility(
                              visible: snapshot.hasData,
                              child: Text(
                                snapshot.data ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return Text(
                            'Meter ID read: ${snapshot.data!.substring(0, 6)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomTextfield(
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    textController: _controller.phoneNumberController,
                    labelText: "Enter home owner's phone number",
                    hintText: 'Ex: 08101564160',
                  ),
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: (() {
                      _controller.checkIfNumberIsValid(context,
                          _controller.phoneNumberController.text.trim());
                    }),
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.grey[200],
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _controller.errorText(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
