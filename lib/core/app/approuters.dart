import 'package:bem_install_app/core/app/app.transitions.dart';
import 'package:bem_install_app/core/app/navigation_service.dart';
import 'package:bem_install_app/src/camera_capture/camera_view/camera_view.dart';
import 'package:bem_install_app/src/capture_qrcode/capture_qrcode_view/qr_view.dart';
import 'package:bem_install_app/src/enter_phone_no/enter_phone_no_view/enter_phone_no_view.dart';
import 'package:bem_install_app/src/homepage/homepage_views/homepage_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
        pageBuilder: (context, state) => CustomSlideTransition(
            child: const MyHomePage(), key: state.pageKey),
      ),

      GoRoute(
        path: '/scanQRView',
        builder: (context, state) => const ScanQRView(),
        pageBuilder: (context, state) => CustomSlideTransition(
            child: const ScanQRView(), key: state.pageKey),
      ),

      GoRoute(
        path: '/enterPhoneNumberView',
        builder: (context, state) => const EnterPhoneNumberView(),
        pageBuilder: (context, state) => CustomSlideTransition(
            child: const EnterPhoneNumberView(), key: state.pageKey),
      ),

      GoRoute(
        path: '/cameraCaptureScreen',
        builder: (context, state) => const CameraCaptureScreen(),
        pageBuilder: (context, state) => CustomSlideTransition(
            child: const CameraCaptureScreen(), key: state.pageKey),
      ),
    ],
  );
}
