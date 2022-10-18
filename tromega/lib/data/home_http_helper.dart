import 'package:tromega/data/trainday.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingHttpHelper {
  //final String authority = 'api.fitnessapp.gang-of-fork.de';
  //final String authority = 'https://api.fitnessapp.gang-of-fork.de/';
  final String authority = 'virtserver.swaggerhub.com';
  final String path = '/FLORIANHASE12/GEtit/1.0.0';

  Future<Trainweek> getLastTrainday() async {
    //gets the LastTrainday data of the last 7 days
    Map<String, dynamic> querys = {};
    querys["userId"] = "";
    querys["days"] = "7";
    String newPath = '$path/lastTraining';
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response response = await http.get(uri);
    List<TrainDay> days = [];
    List<dynamic> data = json.decode(response.body);

    //turns the data into TrainDays
    data.forEach((element) {
      days.add(TrainDay.fromJSON((element)));
    });

    Trainweek lastSevenDays = Trainweek("week", days);

    return lastSevenDays;
  }
}
