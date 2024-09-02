
import 'package:authenticate_touch_faceid_flutter/screens/authorized_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';


class AuthenticateController extends GetxController {
  static AuthenticateController get to => Get.put(AuthenticateController());
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState supportState = _SupportState.unknown;
  // bool? canCheckBiometrics;

  var _canCheckBiometrics= false.obs;

  get canCheckBiometrics => _canCheckBiometrics.value;

  set canCheckBiometrics(value) {
    _canCheckBiometrics.value = value;
  }

  var _availableBiometrics = <BiometricType>[].obs;

  get availableBiometrics => _availableBiometrics.value;

  set availableBiometrics(value) {
    _availableBiometrics.value = value;
  }

  var _authorized = 'Not Authorized'.obs;

  get authorized => _authorized.value;

  set authorized(value) {
    _authorized.value = value;
  }

  // List availableBiometricsList = [];
  var _isAuthenticating = false.obs;

  get isAuthenticating => _isAuthenticating.value;

  set isAuthenticating(value) {
    _isAuthenticating.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    auth.isDeviceSupported().then((bool isSupported) {
      supportState =
          isSupported ? _SupportState.supported : _SupportState.unsupported;
    });
    super.onInit();
  }

  Future<void> checkLocalAuthentication() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      canCheckBiometrics = canAuthenticateWithBiometrics;
    } on PlatformException catch (e) {
      Get.snackbar('PlatformException:', e.toString());
      canCheckBiometrics = false;
    }
  }

  //
  // Future<void> getAvailableBiometricsList() async {
  //   try {
  //     availableBiometricsList =await auth.getAvailableBiometrics();
  //     // print('availableBiometrics:${availableBiometricsList.toString()}');
  //     print('Available Biometrics: $availableBiometricsList');
  //     Get.snackbar('Available Biometrics:', availableBiometricsList.toString());
  //   } catch (e) {
  //     print('Error getting available biometrics: $e');
  //     Get.snackbar('Error getting available biometrics:', e.toString());
  //   }
  // }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      // print(e);
      Get.snackbar('Error getting available biometrics:', e.toString());
    }
    availableBiometrics = availableBiometrics;
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';

      return;
    }

    authorized = authenticated ? 'Authorized' : 'Not Authorized';
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      isAuthenticating = false;
      authorized = 'Authenticating';
    } on PlatformException catch (e) {
      Get.snackbar('PlatformException:', e.toString(),backgroundColor: Colors.red,colorText: Colors.white);

      isAuthenticating = false;
      authorized = 'Error - ${e.message}';

      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    authorized = message;
    if(message=='Authorized'){
      Get.to(() => AuthorizedScreen(),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 500)
        // transitionDuration: const Duration(seconds: 1)
      );
    }else if(message=='Not Authorized'){
      Get.snackbar('Message:', 'Not Authorized, Please Try again',backgroundColor: Colors.red,colorText: Colors.white);
    }
    else{
      cancelAuthentication();
    }

  }

  Future<void> cancelAuthentication() async {
    Get.snackbar('Message:', 'authentication cancelled by you!',backgroundColor: Colors.lightGreenAccent,colorText: Colors.black);
    await auth.stopAuthentication();
    isAuthenticating = false;

  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
