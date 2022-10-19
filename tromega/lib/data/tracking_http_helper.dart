import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/execution.dart';
import 'package:tromega/data/execution_set.dart';
import 'package:tromega/data/training_day.dart';
import 'package:tromega/data/training_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingHttpHelper {
  const TrackingHttpHelper();

  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<TrainingSession> getLastSession(String trainingDayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Sets the userId to a specific existing user for showcase and debugging
    Map<String, dynamic> queries = {
      'userId': prefs.getString('userId') ?? '634dad62663403c8063adc41',
      'trainingDayId': trainingDayId,
    };

    Uri uri = Uri.https(authority, '/lastTrainingSession', queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      TrainingSession lastSession =
          TrainingSession.fromJSON(jsonDecode(res.body));
      if (lastSession.executions.isNotEmpty) {
        return lastSession;
      }
    }

    /// By now there is No session completed by user
    TrainingDay td = await getTrainingDay(trainingDayId);

    /// creates empty Session
    return TrainingSession.fromTrainingDay(td);
  }

  Future<TrainingDay> getTrainingDay(String trainingDayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'trainingDayId': trainingDayId,
    };

    Uri uri = Uri.https(authority, '/trainingDay', queries);
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

    /// Sets the userId to a specific existing user for showcase and debugging
    String userId = prefs.getString('userId') ?? '634dad62663403c8063adc41';
    if (userId == '') {
      return false;
    }

    Uri uri = Uri.https(authority, '/trainingSession');

    session.userId = userId;

    /// Filters undone sets and sets the userId to the current userId
    session.executions = session.executions.map<Execution>((e) {
      List<ExecutionSet> newSets = e.sets.where((e) => e.done).toList();
      return Execution(e.id, userId, e.exercise, e.notes, newSets, e.done);
    }).toList();

    /// reates a json from the current Session and sends it
    http.Response res = await http.post(
      uri,
      body: jsonEncode(session.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );
    print(uri);

    // debugging purpose
    print(jsonEncode(session.toJson()));
    print(res.statusCode);
    print(res.body);

    return res.statusCode == 201;
  }

  Future<Execution?> getLastExecution(
      String trainingDayId, String exerciseId) async {
    // later implemented with special route

    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Sets the userId to a specific existing user for showcase and debugging
    Map<String, dynamic> queries = {
      'userId': prefs.getString('userId') ?? '634dad62663403c8063adc41',
      'trainingDayId': trainingDayId,
    };
    Uri uri = Uri.https(authority, '/lastTrainingSession', queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.body.isNotEmpty) {
      TrainingSession lastSession =
          TrainingSession.fromJSON(jsonDecode(res.body));

      /// gets the execution from the last completed training
      int pos = lastSession.executions
          .indexWhere((exec) => exec.exercise.id == exerciseId);
      if (pos >= 0) {
        return lastSession.executions[pos];
      }
    }
    return null;
  }
}
