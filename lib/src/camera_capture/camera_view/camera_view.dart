import 'package:bem_install_app/src/camera_capture/camera_controller/camera_controller.dart';
import 'package:bem_install_app/src/camera_capture/camera_model/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  final CameraCaptureController _controller = CameraCaptureController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<CameraCaptureModel>(
      create: (context) => CameraCaptureModel(),
      child: Consumer<CameraCaptureModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Upload Picture'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(size.width / 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Provider.of<CameraCaptureModel>(context).imageFile == null
                      ? SizedBox(height: size.height * 0.3, width: 0)
                      : Container(
                          width: size.width,
                          height: size.height * 0.6,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey[100],
                          ),
                          child: Image.file(
                            Provider.of<CameraCaptureModel>(context).imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(
                      height:
                          Provider.of<CameraCaptureModel>(context).imageFile ==
                                  null
                              ? 60
                              : 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.uploadfromGallery(context);
                      },
                      child: Text(
                        Provider.of<CameraCaptureModel>(context).imageFile ==
                                null
                            ? "SELECT FROM GALLERY"
                            : "CHOOSE ANOTHER IMAGE",
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          Provider.of<CameraCaptureModel>(context).imageFile ==
                                  null
                              ? 20
                              : 5),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.captureFromCamera(context);
                      },
                      child: Text(
                        Provider.of<CameraCaptureModel>(context).imageFile ==
                                null
                            ? "CAPTURE WITH CAMERA"
                            : "CAPTURE ANOTHER IMAGE",
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Provider.of<CameraCaptureModel>(context).imageFile == null
                      ? const SizedBox()
                      : InkWell(
                          onTap: (() {
                            _controller.uploadDataToFB(context);
                          }),
                          child: Container(
                            width: size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
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
