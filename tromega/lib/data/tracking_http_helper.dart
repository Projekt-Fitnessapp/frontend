import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/execution.dart';
import 'package:tromega/data/trainingSession.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';
  final String mockAuthority = 'virtserver.swaggerhub.com';
  final String mockPath = '/FLORIANHASE12/GEtit/1.0.0';

  Future<TrainingSession> getLastSession(String trainingDayId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'userId': prefs.getString('userId'),
      'trainingDayId': trainingDayId,
    };

    String path = '/lastSession';
    Uri uri = Uri.https(authority, path, queries);
    http.Response res = await http.get(uri);

    TrainingSession lastSession =
        TrainingSession.fromJSON(jsonDecode(res.body));

    return lastSession;
  }

  Future<bool> saveSession(TrainingSession session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    if (userId == '') {
      return false;
    }

    String path = '/trainingSession';
    Uri uri = Uri.https(authority, path);

    String jsonBody = jsonEncode(session.toJson());
    http.Response res = await http.post(uri, body: jsonBody);

    print(res.statusCode);
    print(res.body);
    return res.statusCode == 200;
  }

  Future<Execution?> getLastExecution(String exerciseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    String path = '/lastExecution';

    Map<String, dynamic> queries = {
      'userId': userId,
      'exerciseId': exerciseId,
    };

    Uri uri = Uri.https(authority, path, queries);

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return Execution.fromJSON(jsonDecode(response.body));
    }
  }

  Future<TrainingSession> getMockSession() async {
    //TrainingSession lastSession = TrainingSession.fromJSON({});
    String newPath = '$mockPath/trainingSession';
    Uri uri = Uri.https(mockAuthority, newPath);

    http.Response response = await http.get(uri);
    TrainingSession lastSession =
        TrainingSession.fromJSON(json.decode(response.body)[0]);

    for (int i = 0; i < 5; i++) {
      Execution newExec = Execution.clone(lastSession.executions.first);
      newExec.notes.add(i.toString());
      lastSession.executions.add(newExec);
    }
    return lastSession;
  }
}
