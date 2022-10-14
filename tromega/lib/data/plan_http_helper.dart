import './trainingPlan.dart';
import './trainingDay.dart';
import './trainingPlans.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanHttpHelper {
  //final String authority = 'api.fitnessapp.gang-of-fork.de';
  final String authority = 'virtserver.swaggerhub.com';
  final String path = '/FLORIANHASE12/GEtit/1.0.0';

  Future<TrainingPlan> getTrainingPlan(String trainingPlanId) async {
    final queryParameters = {'trainingPlanId': trainingPlanId};
    TrainingPlan trainingPlan;

    String newPath = '$path/trainingPlan';
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

    String newPath = '$path/trainingDay';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      trainingDay = TrainingDay.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load trainingDay');
    }
    return trainingDay;
  }

  Future<TrainingPlans> getTrainingPlans(String userId) async {
    final queryParameters = {'userId': userId};
    TrainingPlans trainingPlans;

    String newPath = '$path/myPlans';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      trainingPlans = TrainingPlans.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load trainingPlans');
    }
    return trainingPlans;
  }

  Future<bool> postTrainingPlan(
      String userId, TrainingPlan trainingPlan) async {
    final queryParameters = {'userId': userId};

    String newPath = '$path/trainingPlan';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response response = await http.post(uri, body: {trainingPlan});

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> putTrainingPlan(
      String trainingPlanId, TrainingPlan trainingPlan) async {
    final queryParameters = {'trainingPlan': trainingPlanId};

    String newPath = '$path/trainingPlan';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response response = await http.put(uri, body: {trainingPlan});

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
