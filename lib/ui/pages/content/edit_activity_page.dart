//import 'dart:ffi';

import 'package:f_web_authentication/domain/models/activity.dart';
import 'package:f_web_authentication/ui/pages/content/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../controller/activity_controller.dart';
import '../../controller/location_controller.dart';

class EditActivityPage extends StatefulWidget {
  const EditActivityPage({super.key});

  @override
  State<EditActivityPage> createState() => _EditUserPageState();
}


String obtenerCoordenada(String coordenadas, int parametro) {
  List<String> partes = coordenadas.split(',');
  
  if (parametro == 1) {
    return partes[0]; // Devuelve la latitud
  } else if (parametro == 2) {
    return partes[1]; // Devuelve la longitud
  } else {
    return "Inválido"; // Manejo de un parámetro incorrecto
  }
}


String unirCoordenadas(String latitud, String  longitud) {
  String coordenadas = '$latitud,$longitud';
  return coordenadas;
}


class _EditUserPageState extends State<EditActivityPage> {
  Activity activity = Get.arguments[0];
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerLocation = TextEditingController();

  final controllerLatitud = TextEditingController();
  final controllerLongitud = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    ActivityController actController = Get.find();
    controllerName.text = activity.name;
    controllerDescription.text = activity.description;
    controllerDate.text = activity.date;
    controllerLocation.text = activity.location;

    String latitud = obtenerCoordenada(activity.location, 1);
    String longitud = obtenerCoordenada(activity.location, 2);
    controllerLatitud.text = latitud;
    controllerLongitud.text = longitud;


    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
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
            
            location(),

            const SizedBox(
              height: 20,
            ),

            TextField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                )),
            const SizedBox(
              height: 10,
            ),

            const Expanded(
              child: SizedBox(height: 10),
            ),

            

            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
                padding: const EdgeInsets.all(14.0),
              ),
              onPressed: () async {
                await actController.updateActivity(Activity(
                  id: activity.id,
                  name: activity.name,
                  description: controllerDescription.text,
                  date: controllerDate.text,
                  location: unirCoordenadas(controllerLatitud.text,controllerLongitud.text),
                  ended: activity.ended));
                  Get.back();
              },
              child: const Text("Actualizar")
            ),

            const SizedBox(height: 15),
            
            if(!activity.ended)...[
              ElevatedButton(
                style:  ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.all(14.0),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 0, 240, 8)
                ),
                onPressed: () async {
                  await actController.updateActivity(Activity(
                    id: activity.id,
                    name: activity.name,
                    description: controllerDescription.text,
                    date: controllerDate.text,
                    location: unirCoordenadas(controllerLatitud.text,controllerLongitud.text),
                    ended: true));
                  Get.back();
                },
                child: const Text("Finalizar actividad")),],

            
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


  location(){
    LocationController locationController = Get.find();
    
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: const Text('Lugar'),
          subtitle: Text(activity.location),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: controllerLatitud,
                              decoration: const InputDecoration(labelText: 'Latitud',border: OutlineInputBorder(),),
                            ),
                          )
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: controllerLongitud,
                              decoration: const InputDecoration(labelText: 'Longitud',border: OutlineInputBorder(),),
                            ),
                          )
                        )
                      ]
                    )
                  ),
                  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex:1,
                          child: TextButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              try {
                                var lat1 = double.parse(controllerLatitud.text);
                                var lon1 = double.parse(controllerLongitud.text);
                                locationController.getLocation(lat1,lon1,true);
                              } catch (e) {
                                Get.snackbar('Error.....', e.toString(),
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(12.0),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text("Ver distancia"),
                          )
                        ),
                        const SizedBox(width: 15),
                        //calculo
                        
                        Expanded(
                          flex:2,
                          child: Center(
                              child: Obx(() => Text("está a ${locationController.distancia} Km de distancia", ))
                            )
                        )
                      ]
                    )
                  ),
                  
                ]
              )
            )
          ],
        ),
      ]
    );
  }
}