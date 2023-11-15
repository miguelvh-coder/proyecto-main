import 'package:f_web_authentication/domain/models/activity.dart';
import 'package:f_web_authentication/ui/pages/content/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../controller/activity_controller.dart';

class EditActivityPage extends StatefulWidget {
  const EditActivityPage({super.key});

  @override
  State<EditActivityPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditActivityPage> {
  Activity activity = Get.arguments[0];
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ActivityController actController = Get.find();
    controllerName.text = activity.name;
    controllerDescription.text = activity.description;
    controllerDate.text = activity.date;
    controllerLocation.text = activity.location;
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              child: activity.ended==false ? Text('show') : null,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(activity.name, style: const TextStyle(color: Color.fromARGB(255, 30, 30, 100), fontSize: 24)), 
            const SizedBox(
              height: 20,
            ),

            TextField(
                controller: controllerDate,
                decoration: const InputDecoration(
                  labelText: 'Fecha de realización',
                )),
            const SizedBox(
              height: 20,
            ),
            
            TextField(
                controller: controllerLocation,
                //keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Lugar',
                )),
            const SizedBox(
              height: 20,
            ),

            TextField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                )),
            const SizedBox(
              height: 100,
            ),

            
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(activity.ended)...[const SizedBox(width: 350),],
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 26),
                          padding: const EdgeInsets.all(18.0),
                        ),
                          onPressed: () async {
                            await actController.updateActivity(Activity(
                                id: activity.id,
                                name: activity.name,
                                description: controllerDescription.text,
                                date: controllerDate.text,
                                location: controllerLocation.text,
                                ended: activity.ended));
                            Get.back();
                          },
                          child: const Text("Actualizar"))),
                  const SizedBox(width: 350,),

                  if(!activity.ended)...[
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 26),
                          padding: const EdgeInsets.all(18.0),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 0, 240, 8)
                        ),
                          onPressed: () async {
                            await actController.updateActivity(Activity(
                                id: activity.id,
                                name: activity.name,
                                description: controllerDescription.text,
                                date: controllerDate.text,
                                location: controllerLocation.text,
                                ended: true));
                            Get.back();
                          },
                          child: const Text("Finalizar actividad"))),]
                ],
              ),
            )
          ],
        ),
      ),

      //chat
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("Going to chat");
          Get.to(() => const ChatPage(), arguments: [activity, activity.id]);
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}