import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/activity.dart';
import '../repositories/repository.dart';

class ActivityUseCase {
  final Repository _repository = Get.find();

  ActivityUseCase();

  Future<List<Activity>> getActivities() async {
    logInfo("Getting users  from UseCase");
    return await _repository.getActivities();
  }

  Future<void> addActivity(Activity act) async => await _repository.addActivity(act);

  Future<void> updateActivity(Activity act) async =>
      await _repository.updateActivity(act);

  deleteActivity(int id) async => await _repository.deleteActivity(id);

  simulateProcess() async => await _repository.simulateProcess();
}