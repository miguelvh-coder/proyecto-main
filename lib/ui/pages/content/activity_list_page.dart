import 'package:f_web_authentication/ui/pages/content/edit_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../domain/models/user.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/user_controller.dart';
import 'new_user_page.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  UserController userController = Get.find();
  AuthenticationController authenticationController = Get.find();

  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      logInfo(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenido"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Container(
        
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              children:[
                const Text("PENDIENTE", style: TextStyle(color: Color.fromARGB(255, 200, 90, 90), fontSize: 24)),
                const SizedBox(height: 20),
                Expanded(child: _getXlistView()),
                const Text("FINALIZADO", style: TextStyle(color: Color.fromARGB(255, 90, 200, 90), fontSize: 24)),
                const SizedBox(height: 20),
                Expanded(child:_endedActivities()),
              ]
            )
          )
      ),
      

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("Add activity");
          Get.to(() => const NewUserPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }



  Widget _getXlistView() {
    return Obx(
      () => ListView.builder(
        itemCount: userController.users.length,
        itemBuilder: (context, index) {
          User user = userController.users[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Deleting",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            onDismissed: (direction) {
              userController.deleteUser(user.id!);
            },
            child: Card(
              shadowColor: const Color.fromARGB(255, 255, 81, 81),
              color: const Color.fromARGB(180, 255, 255, 255),
              child: ListTile(
                title: const Text("proyecto"), //user.name
                subtitle: const Text("Hacer la app de móvil"), //user.email
                onTap: () {
                  Get.to(() => const EditUserPage(),
                      arguments: [user, user.id]);
                },
              ),
            ),
          );
        },
      ),
    );
  }





  Widget _endedActivities() {
    return Obx(
      () => ListView.builder(
        itemCount: userController.users.length,
        itemBuilder: (context, index) {
          User user = userController.users[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Deleting",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            onDismissed: (direction) {
              userController.deleteUser(user.id!);
            },
            child: Card(
              shadowColor: const Color.fromARGB(255, 81, 255, 81),
              color: const Color.fromARGB(180, 255, 255, 255),
              child: ListTile(
                title: const Text("proyecto"), //user.name
                subtitle: const Text("Hacer la interfaz"), //user.email
                onTap: () {
                  Get.to(() => const EditUserPage(),
                      arguments: [user, user.id]);
                },
              ),
            ),
          );
        },
      ),
    );
  }










}
