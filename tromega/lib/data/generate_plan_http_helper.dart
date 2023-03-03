import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tromega/data/generatedPlanPreferences.dart';

class GeneratePlanHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<String> postGeneratedPlanPreferences(
      GeneratedPlanPreferences generatedPlanPreferences) async {
    String newPath = '/generatedTrainingsplan';
    Uri uri = Uri.https(authority, newPath);

    final body = jsonEncode(generatedPlanPreferences.toJson());

    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 201) {
      return response.body;
    }
    return "Error beim senden der Daten";
  }
}
