import 'package:f_web_authentication/domain/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/activity_controller.dart';
import '../../controller/location_controller.dart';

class NewActivityPage extends StatefulWidget {
  const NewActivityPage({Key? key}) : super(key: key);

  @override
   State<NewActivityPage> createState() => _NewActivityPageState();
}

String unirCoordenadas(String latitud, String  longitud) {
  String coordenadas = '$latitud,$longitud';
  return coordenadas;
}

class _NewActivityPageState extends State<NewActivityPage> {
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerLocation = TextEditingController();

  final controllerLatitud = TextEditingController();
  final controllerLongitud = TextEditingController();

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

            location(),
            
            const SizedBox(height: 30,),

            TextField(
                controller: controllerDescription,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la actividad',
                )),
            const Expanded(child: SizedBox(height: 30)),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(flex:1,child: SizedBox(width: 50)),

                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 22),
                          padding: const EdgeInsets.all(18.0),
                        ),
                          onPressed: () async {
                            await actController.addEAct(Activity(
                                name: controllerName.text,
                                description: controllerDescription.text,
                                date: controllerDate.text,
                                location: unirCoordenadas(controllerLatitud.text, controllerLongitud.text),
                                ended: false));
                            Get.back();
                          },
                          child: const Text("Guardar"))),

                    const Expanded(flex:1,child: SizedBox(width: 50)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  location(){
    LocationController locationController = Get.find();

    return Column(
      children: <Widget>[

        ExpansionTile(
          title: const Text('Lugar'),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controllerLatitud,
                            decoration: const InputDecoration(labelText: 'Latitud',border: OutlineInputBorder(),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controllerLongitud,
                            decoration: const InputDecoration(labelText: 'Longitud',border: OutlineInputBorder(),),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(12.0),
                            textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                            try {
                              await locationController.getLocation(0,0,false);
                              var lat1 = locationController.userLocation.value.latitude;
                              var lon1 = locationController.userLocation.value.longitude;
                              String latitud = lat1.toString();
                              String longitud = lon1.toString();
                              controllerLatitud.text = latitud;
                              controllerLongitud.text = longitud;
                            } catch (e) {
                              Get.snackbar('Error.....', e.toString(),
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                            }
                    },
                    child: const Text("Usar ubicación actual")
                  ),
                  
                  const SizedBox(height: 10),
                ]
              )


          ],
        )

      ]
    );
  }

}
