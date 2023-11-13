import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/activity.dart';
import '../../domain/use_case/activity_usecase.dart';

class ActivityController extends GetxController {

  final RxList<Activity> generalActivities = <Activity>[].obs;
  final RxList<Activity> _endedActivities = <Activity>[].obs;
  final RxList<Activity> _goingActivities = <Activity>[].obs;
  final ActivityUseCase activityUseCase = Get.find();

  List<Activity> get eActs => _endedActivities;
  List<Activity> get gActs => _goingActivities;
  //hay cosas que arreglar en los objetos de datos y relaciones
  
  @override
  void onInit() {
    getActs();
    super.onInit();
  }

  getActs() async {
    logInfo("Getting activities");
    generalActivities.value = await activityUseCase.getActivities();

    for (var index = 0; index == generalActivities.length; index++) {
      if(generalActivities[index].ended==true){
        _endedActivities.add(generalActivities[index]);
      }else{
        _goingActivities.add(generalActivities[index]);
      }
    }
  }

  addEAct(Activity activity) async {
    logInfo("Ending activity");
    await activityUseCase.addActivity(activity);
    getActs();
  }

  updateActivity(Activity activity) async {
    logInfo("Update user");
    await activityUseCase.updateActivity(activity);
    getActs();
  }

  void deleteAct(int id) async {
    await activityUseCase.deleteActivity(id);
    getActs();
  }

  void simulateProcess() async {
    await activityUseCase.simulateProcess();
  }
}