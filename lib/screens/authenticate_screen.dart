import 'package:authenticate_touch_faceid_flutter/controllers/authenticate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticateController _authenticateController = Get.put(AuthenticateController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:  Text('Biometrics Authenticate app',style: TextStyle(color: Colors.white),),
        ),
        body: Obx(
          () => ListView(
            padding: const EdgeInsets.only(top: 30),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // if (_authenticateController.supportState ==
                  //     _SupportState.unknown)
                  //   const CircularProgressIndicator()
                  // else if (_authenticateController.supportState ==
                  //     _SupportState.supported)
                  //   const Text('This device is supported')
                  // else
                  //   const Text('This device is not supported'),
                  // const Divider(height: 100),
                  // Text(
                  //     'Can check biometrics: ${_authenticateController.canCheckBiometrics}\n'),
                  // ElevatedButton(
                  //   onPressed: _authenticateController.checkLocalAuthentication,
                  //   child: const Text('Check biometrics'),
                  // ),
                  // const Divider(height: 100),
                  // Text(
                  //     'Available biometrics: ${_authenticateController.availableBiometrics}\n'),
                  // ElevatedButton(
                  //   onPressed: _authenticateController.getAvailableBiometrics,
                  //   child: const Text('Get available biometrics'),
                  // ),
                  // const Divider(height: 100),
                  Icon(Icons.lock ,color:  Colors.black,size: 50,),
                  // Text('Current State'),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Fingerprint / Face Authentication Required \n',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                  ),
                  // Text('${_authenticateController.authorized}\n'),

                  Container(
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                      onPressed: _authenticateController
                          .authenticateWithBiometrics,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_authenticateController.isAuthenticating
                              ? 'Cancel'
                              : '',style: TextStyle(color: Colors.white,fontSize: 18),),
                          const Icon(Icons.fingerprint,color: Colors.white,size: 70,),
                        ],
                      ),
                    ),
                  ),


                  // if (_authenticateController.isAuthenticating)
                  //   ElevatedButton(
                  //     onPressed: _authenticateController.cancelAuthentication,
                  //     child: const Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: <Widget>[
                  //         Text('Cancel Authentication'),
                  //         Icon(Icons.cancel),
                  //       ],
                  //     ),
                  //   )
                  // else
                  //   Column(
                  //     children: <Widget>[
                  //       ElevatedButton(
                  //         onPressed: _authenticateController.authenticate,
                  //         child: const Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Text('Authenticate'),
                  //             Icon(Icons.perm_device_information),
                  //           ],
                  //         ),
                  //       ),
                  //       ElevatedButton(
                  //         onPressed: _authenticateController
                  //             .authenticateWithBiometrics,
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Text(_authenticateController.isAuthenticating
                  //                 ? 'Cancel'
                  //                 : 'Authenticate: biometrics only'),
                  //             const Icon(Icons.fingerprint),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),


                ],
              ),
            ],
          ),
        ));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
