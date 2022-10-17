import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_controllers/qr_controller.dart';
import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_models/qr_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanQRView extends StatefulWidget {
  const ScanQRView({super.key});

  @override
  State<ScanQRView> createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView> {
  final ScanQRController _controller = ScanQRController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ScanQRModel>(
      create: (context) => ScanQRModel(),
      child: Consumer<ScanQRModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Scan QR Code'),
            ),
            body: Padding(
              padding: EdgeInsets.all(size.width / 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: () => _controller.scanQRcode(context),
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_2_outlined,
                              size: size.width / 3,
                            ),
                            const Text('Click to scan QR code')
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 8)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
