import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/activity.dart';
import 'package:http/http.dart' as http;

class ActivityDataSource {
  final String apiKey = 'W4uoN7';

  Future<List<Activity>> getActivities() async {
    List<Activity> users = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      users = List<Activity>.from(data.map((x) => Activity.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  Future<bool> addActivity(Activity act) async {
    logInfo("Web service, Adding user");

    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(act.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateActivity(Activity act) async {
    final response = await http.put(
      Uri.parse("https://retoolapi.dev/$apiKey/data/${act.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(act.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteActivity(int id) async {
    final response = await http.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> simulateProcess(String baseUrl, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      logInfo('simulateProcess access ok');
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }
}
