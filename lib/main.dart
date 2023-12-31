import 'package:f_web_authentication/domain/use_case/user_usecase.dart';
import 'package:f_web_authentication/domain/use_case/activity_usecase.dart';
import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/authentication_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/controller/activity_controller.dart';
import 'package:f_web_authentication/ui/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'domain/repositories/repository.dart';
import 'domain/use_case/authentication_usecase.dart';
import 'domain/use_case/locator_service.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  Get.put(Repository());
  Get.put(AuthenticationUseCase());
  Get.put(UserUseCase());
  Get.put(ActivityUseCase());
  Get.put(AuthenticationController());
  Get.put(UserController());
  Get.put(ActivityController());
  Get.put(LocatorService());
  Get.put(LocationController());
  runApp(const MyApp());
}

//NOTA: Get.put(ActivityController()); genera conflicto?

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Central(),
    );
  }
}
