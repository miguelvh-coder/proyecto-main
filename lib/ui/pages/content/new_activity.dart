import 'package:f_web_authentication/domain/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/activity_controller.dart';

class NewActivityPage extends StatefulWidget {
  const NewActivityPage({Key? key}) : super(key: key);

  @override
   State<NewActivityPage> createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ActivityController actController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva actividad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la actividad',
                )),
            const SizedBox(height: 30,),

            TextField(
                controller: controllerDate,
                decoration: const InputDecoration(
                  labelText: 'Fecha de realización',
                )),
            const SizedBox(height: 30,),

            TextField(
                controller: controllerLocation,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Lugar de realización',
                )),
            const SizedBox(height: 30,),

            TextField(
                controller: controllerDescription,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la actividad',
                )),
            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () async {
                            await actController.addEAct(Activity(
                                name: controllerName.text,
                                description: controllerDescription.text,
                                date: controllerDate.text,
                                location: controllerLocation.text,
                                ended: false));
                            Get.back();
                          },
                          child: const Text("Guardar")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
