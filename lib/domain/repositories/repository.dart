import 'package:f_web_authentication/data/datasources/remote/authentication_datasource.dart';

import '../../data/datasources/remote/user_datasource.dart';
import '../models/user.dart';
import '../models/activity.dart';
import '../../data/datasources/remote/activity_datasource.dart';

class Repository {
  late AuthenticationDatatasource _authenticationDataSource;
  late UserDataSource _userDatatasource;
  late ActivityDataSource _actDatatasource;
  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "http://ip172-18-0-103-cjvmcv8gftqg00dhebr0-8000.direct.labs.play-with-docker.com";

  Repository() {
    _authenticationDataSource = AuthenticationDatatasource();
    _userDatatasource = UserDataSource();
  }

  Future<bool> login(String email, String password) async {
    token = await _authenticationDataSource.login(_baseUrl, email, password);
    return true;
  }

  Future<bool> signUp(String email, String password) async =>
      await _authenticationDataSource.signUp(_baseUrl, email, password);

  Future<bool> logOut() async => await _authenticationDataSource.logOut();

  Future<List<User>> getUsers() async => await _userDatatasource.getUsers();

  Future<bool> addUser(User user) async =>
      await _userDatatasource.addUser(user);

  Future<bool> updateUser(User user) async =>
      await _userDatatasource.updateUser(user);

  Future<bool> deleteUser(int id) async =>
      await _userDatatasource.deleteUser(id);



  Future<List<Activity>> getActivities() async => await _actDatatasource.getActivities();

  Future<bool> addActivity(Activity act) async =>
      await _actDatatasource.addActivity(act);

  Future<bool> updateActivity(Activity act) async =>
      await _actDatatasource.updateActivity(act);

  Future<bool> deleteActivity(int id) async =>
      await _actDatatasource.deleteActivity(id);

  Future<bool> simulateProcess() async =>
      await _actDatatasource.simulateProcess(_baseUrl, token);//cambiar luego a 
}
