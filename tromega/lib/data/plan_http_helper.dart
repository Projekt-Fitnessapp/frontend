import 'package:tromega/data/exerciseSetsReps.dart';

import './trainingPlan.dart';
import './trainingDay.dart';
import './exercise.dart';
import 'dart:convert';
import './account.dart';
import 'package:http/http.dart' as http;

class PlanHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<List<ExerciseSetsReps>> getExercise() async {
    List<ExerciseSetsReps> exercises = [];

    String newPath = '/exercises';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      for (var exerciseRes in response) {
        Exercise exercise = Exercise.fromJSON(exerciseRes);
        ExerciseSetsReps exerciseSetsReps = ExerciseSetsReps(exercise, 3, 10);
        exercises.add(exerciseSetsReps);
      }
    } else {
      throw Exception('Failed to load trainingPlan');
    }
    return exercises;
  }

  Future<TrainingPlan> getTrainingPlan(String trainingPlanId) async {
    final queryParameters = {'trainingPlanId': trainingPlanId};
    TrainingPlan trainingPlan;

    String newPath = '/trainingPlan';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      trainingPlan = TrainingPlan.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load trainingPlan');
    }
    return trainingPlan;
  }

  Future<TrainingDay> getTrainingDay(String trainingDayId) async {
    final queryParameters = {'trainingDayId': trainingDayId};
    TrainingDay trainingDay;

    String newPath = '/trainingDay';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      trainingDay = TrainingDay.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load trainingDay');
    }
    return trainingDay;
  }

  Future<List<TrainingPlan>> getTrainingPlans(String userId) async {
    final queryParameters = {'userId': userId};
    List<TrainingPlan> trainingPlans = [];

    String newPath = '/myPlans';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      for (var plan in jsonDecode(res.body)) {
        trainingPlans.add(TrainingPlan.fromJSON(plan));
      }
    } else {
      throw Exception('Failed to load myPlans');
    }
    return trainingPlans;
  }

  Future<String> postTrainingPlan(
      String userId, TrainingPlan trainingPlan) async {
    final queryParameters = {'userId': userId};

    String newPath = '/trainingPlan';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    final body = jsonEncode(trainingPlan.toJsonWoId());

    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 201) {
      return response.body;
    }
    return "";
  }

  Future<String> postTrainingDay(TrainingDay trainingDay, String userId) async {
    final queryParameters = {'userId': userId};

    String newPath = '/trainingDay';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(trainingDay.toJsonWoId()));
    if (response.statusCode == 201) {
      return response.body;
    }
    return "";
  }

  Future<bool> putTrainingPlan(
      String trainingPlanId, TrainingPlan trainingPlan) async {
    final queryParameters = {'trainingPlanId': trainingPlanId};

    String newPath = '/trainingPlan';
    Uri uri = Uri.https(authority, newPath, queryParameters);
    trainingPlan.setId = trainingPlanId;
    http.Response response = await http.put(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(trainingPlan.toJson()));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> putActivePlan(String userId, String trainingPlanId) async {
    final queryParameters = {
      'userId': userId,
      'trainingPlanId': trainingPlanId,
    };

    String newPath = '/myPlans/active';
    Uri uri = Uri.https(authority, newPath, queryParameters);
    http.Response response =
        await http.put(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> putAccount(String userId, String trainingPlanId) async {
    final queryParameters = {'userId': userId};

    String newPath = '/account';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    Account account = await getAccount(userId);

    http.Response response = await http.put(uri,
        body: jsonEncode(account.toJsonNewActivePlan(trainingPlanId)));

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<Account> getAccount(String userId) async {
    final queryParameters = {'userId': userId};
    Account account;

    String newPath = '/account';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      account = Account.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load account');
    }
    return account;
  }
}
