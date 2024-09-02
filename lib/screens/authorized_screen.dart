import 'package:authenticate_touch_faceid_flutter/controllers/authenticate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorizedScreen extends StatelessWidget {
  AuthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticateController _authenticateController =
        Get.put(AuthenticateController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: null,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back,color:  Colors.white,),
        //   onPressed: () {
        //         AuthenticateController.to.authorized = 'Not Authorized';
        //         Get.back();
        //     // Navigator.pop(context);
        //   },
        // ),
        title: Text(
          'Authorized Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 50,),
              Icon(
                Icons.lock_open,
                color: Colors.green,
                size: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Fingerprint / Face Recognised Succesfully!\n',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              // Text('${_authenticateController.authorized}\n'),
              ElevatedButton(
                onPressed: () {
                  AuthenticateController.to.authorized = 'Not Authorized';
                  Get.back();
                },
                child: Text(
                  'Cancel Authentication',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
