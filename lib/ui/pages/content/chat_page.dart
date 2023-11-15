import 'package:f_web_authentication/domain/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/activity_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Activity activity = Get.arguments[0];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
      ),
    );
  }
}