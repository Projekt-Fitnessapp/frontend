import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/generatedPlanPreferences.dart';

class GeneratePlanHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<bool> postGeneratedPlanPreferences(
      GeneratedPlanPreferences generatedPlanPreferences) async {
    String newPath = '/body';
    Uri uri = Uri.https(authority, newPath);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonBody = jsonEncode(generatedPlanPreferences.toJson());
    http.Response res = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
      body: jsonBody,
    );

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
