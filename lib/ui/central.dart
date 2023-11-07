import 'package:f_web_authentication/ui/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/authentication/login_page.dart';
import 'pages/authentication/signup.dart';
import 'pages/content/activity_list_page.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController = Get.find();
    return Obx(() => authenticationController.isLogged
        ? const ActivityListPage()
        //: const LoginPage());
        : const SignUp());
  }
}
