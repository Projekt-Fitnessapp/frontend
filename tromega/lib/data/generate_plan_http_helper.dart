import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tromega/data/generatedPlanPreferences.dart';
import 'package:tromega/data/trainingPlan.dart';

class GeneratePlanHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<TrainingPlan> postGeneratedPlanPreferences(
      GeneratedPlanPreferences generatedPlanPreferences) async {
    // Die gesammelten Präferenzen für generieten Trainingsplan ans Bakcned
    // übermitteln
    String newPath = '/generatedTrainingsplan';
    Uri uri = Uri.https(authority, newPath);
    TrainingPlan trainingPlan;

    final body = jsonEncode(generatedPlanPreferences.toJson());

    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    // Bei erfolgreicher Übermittlung wird der generierte Plan zurückgegeben.
    // Dieser wird hier von der JSON in ein Objekt überführt und an die
    // GeneratePlanView zurückgegeben
    if (response.statusCode == 201) {
      trainingPlan = TrainingPlan.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("Failed to generate Plan");
    }
    return trainingPlan;
  }
}
