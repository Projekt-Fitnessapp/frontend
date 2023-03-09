import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/trainday.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';
  //final String authority = 'https://api.fitnessapp.gang-of-fork.de/';

  Future<Trainweek> getLastTrainday() async {
    //gets the LastTrainday data of the last 7 days

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> querys = {};
    querys["userId"] = prefs.getString('userId') ?? '';
    querys["days"] = "7";
    String newPath = '/lastTraining';
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );
    List<TrainDay> days = [];
    List<dynamic> data = json.decode(response.body)['data'];

    //turns the data into TrainDays
    data.forEach((element) {
      days.add(TrainDay.fromJSON((element)));
    });

    Trainweek lastSevenDays = Trainweek("week", days);

    return lastSevenDays;
  }

  Future<List<String>> getNextTrainingDayId() async {
    // gets the TrainingDayId of the next trainingDay to be completed
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> queries = {
      'userId': prefs.getString('userId') ?? '',
    };

    Uri uri = Uri.https(authority, '/nextTraining', queries);
    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    // return object expanded to surpass trainingPlanId for tracking purposes
    List<String> ids = [];
    ids.add(jsonDecode(res.body)['_id'] ?? '');
    ids.add(jsonDecode(res.body)['trainingPlanId'] ?? '');


    /// Body equals an trainingDay --> get Id with _id
    return ids;
  }

  Future<String> getNextTrainingDayName() async {
    // gets the TrainingDayId of the next trainingDay to be completed
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final queryParameters = {
      'userId': prefs.getString('userId') ?? '',
    };

    Uri uri = Uri.https(authority, '/nextTraining', queryParameters);
    http.Response res = await http.get(uri);

    /// Body equals an trainingDay --> get Id with _id
    return jsonDecode(res.body)['name'] ?? 'Kein Plan ausgewählt';
  }
}
