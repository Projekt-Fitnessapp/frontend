import 'package:tromega/data/trainingSession.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingHttpHelper {
  //final String authority = 'api.fitnessapp.gang-of-fork.de';
  final String authority = 'virtserver.swaggerhub.com';
  final String path = '/FLORIANHASE12/GEtit/1.0.0';

  Future<TrainingSession> getLastSession(String trainingDayId) async {
    TrainingSession lastSession = TrainingSession.fromJSON({});

    String newPath = '$path/lastSession/$trainingDayId';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.get(uri);

    return lastSession;
  }

  Future<TrainingSession> getMockSession() async {
    //TrainingSession lastSession = TrainingSession.fromJSON({});

    String newPath = '$path/trainingSession';
    Uri uri = Uri.https(authority, newPath);

    http.Response response = await http.get(uri);
    TrainingSession lastSession = TrainingSession.fromJSON(json.decode(response.body)[0]);

    return lastSession;
  }
}
