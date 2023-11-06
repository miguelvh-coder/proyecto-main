import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/user.dart';
import '../../domain/use_case/user_usecase.dart';

class MessageController extends GetxController {
  final RxList<User> _users = <User>[].obs;
  final UserUseCase userUseCase = Get.find();

  List<User> get users => _users;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  getUsers() async {
    logInfo("Getting users");
    _users.value = await userUseCase.getUsers();
  }

  addUser(User user) async {
    logInfo("Add user");
    await userUseCase.addUser(user);
    getUsers();
  }

  updateUser(User user) async {
    logInfo("Update user");
    await userUseCase.updateUser(user);
    getUsers();
  }

  void deleteUser(int id) async {
    await userUseCase.deleteUser(id);
    getUsers();
  }

  void simulateProcess() async {
    await userUseCase.simulateProcess();
  }
}
