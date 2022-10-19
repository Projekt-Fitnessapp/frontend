import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/execution.dart';
import 'package:tromega/data/training_day.dart';
import 'package:tromega/data/training_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingHttpHelper {
  const TrackingHttpHelper();

  final String authority = 'api.fitnessapp.gang-of-fork.de';
  final String mockAuthority = 'virtserver.swaggerhub.com';
  final String mockPath = '/FLORIANHASE12/GEtit/1.0.0';

  Future<TrainingSession> getLastSession(String trainingDayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'userId': '634dad62663403c8063adc41', //prefs.getString('userId'),
      'trainingDayId': trainingDayId,
    };

    String path = '/lastTrainingSession';
    Uri uri = Uri.https(authority, path, queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 200) {
      return TrainingSession.fromJSON(jsonDecode(res.body));
    }
    TrainingDay td = await getTrainingDay(trainingDayId);
    return TrainingSession.fromTrainingDay(td);
  }

  Future<TrainingDay> getTrainingDay(String trainingDayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'trainingDayId': trainingDayId,
    };
    String path = '/trainingDay';

    Uri uri = Uri.https(authority, path, queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    return TrainingDay.fromJson(jsonDecode(res.body));
  }

  Future<bool> saveSession(TrainingSession session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '634dad62663403c8063adc41';
    if (userId == '') {
      return false;
    }

    String path = '/trainingSession';
    Uri uri = Uri.https(authority, path);

    session.userId = userId;
    session.executions = session.executions
        .map<Execution>(
            (e) => Execution(e.id, userId, e.exercise, e.notes, e.sets, e.done))
        .toList();

    String jsonBody = jsonEncode(session.toJson());
    http.Response res = await http.post(
      uri,
      body: jsonBody,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );
    print(jsonBody);
    print(res.statusCode);
    print(res.body);

    return res.statusCode == 201;
  }

  Future<Execution?> getLastExecution(
      String trainingDayId, String exerciseId) async {
    // later with special route

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'userId': '634dad62663403c8063adc41', //prefs.getString('userId'),
      'trainingDayId': trainingDayId,
    };
    String path = '/lastTrainingSession';
    Uri uri = Uri.https(authority, path, queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.body.isNotEmpty) {
      TrainingSession lastSession =
          TrainingSession.fromJSON(jsonDecode(res.body));
      int pos = lastSession.executions
          .indexWhere((exec) => exec.exercise.id == exerciseId);
      if (pos >= 0) {
        return lastSession.executions[pos];
      }
    }
  }
}
