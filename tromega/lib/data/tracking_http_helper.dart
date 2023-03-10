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
      'userId': prefs.getString('userId') ?? '',
      'trainingDayId': trainingDayId,
    };

    Uri uri = Uri.https(authority, '/lastTrainingSession', queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 200) {
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
    String userId = prefs.getString('userId') ?? '';
    if (userId == '') {
      return false;
    }

    Map<String, dynamic> queries = {
      'trainingPlanId': session.trainingDayId,
    };

    Uri uri = Uri.https(authority, '/trainingSession', queries);

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

    return res.statusCode == 201 || res.statusCode == 202;
  }

  Future<Execution?> getLastExecution(
      String trainingDayId, String exerciseId) async {
    // later implemented with special route

    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Sets the userId to a specific existing user for showcase and debugging
    Map<String, dynamic> queries = {
      'userId': prefs.getString('userId') ?? '',
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
          .indexWhere((exec) => exec.exercise.getId == exerciseId);
      if (pos >= 0) {
        return lastSession.executions[pos];
      }
    }
    return null;
  }
}
