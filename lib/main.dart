// ignore_for_file: depend_on_referenced_packages

import 'package:bem_install_app/core/app/approuters.dart';
import 'package:bem_install_app/src/camera_capture/camera_model/camera_model.dart';
import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_models/qr_model.dart';
import 'package:bem_install_app/src/enter_phone_no/enter_phone_no_model/enter_phone_no_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CameraCaptureModel()),
        ChangeNotifierProvider(create: (_) => ScanQRModel()),
        ChangeNotifierProvider(create: (_) => EnterPhoneNumberModel())
      ],
      child: MaterialApp.router(
        title: 'BEM Install',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),

        /// GoRouter specific params
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  BuildContext? get ctx => _router.routerDelegate.navigatorKey.currentContext;
  final _router = AppRouter.router;
}
