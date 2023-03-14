// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/execution.dart';
import 'package:tromega/data/classes/execution_set.dart';
import 'package:tromega/data/classes/training_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'classes/account.dart';
import 'classes/body.dart';
import 'classes/exercise.dart';
import 'classes/exercise_sets_reps.dart';
import 'classes/generated_plan_preferences.dart';
import 'classes/stats_pair.dart';
import 'classes/trainday.dart';
import 'classes/training_day.dart';
import 'classes/training_plan.dart';

class HttpHelper {
  const HttpHelper();

  final String authority = 'api.fitnessapp.gang-of-fork.de';

  //----------------------------------------------------------------------------------------
  //-------------------------------Account Http Helper--------------------------------------
  //----------------------------------------------------------------------------------------
  Future<bool> accountExist(String googleId) async {
    String newPath = '/account';
    Map<String, dynamic> querys = {};
    querys["googleId"] = googleId;
    Uri uri = Uri.https(authority, newPath, querys);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Account> getAccountWithGoogleId(String googleId) async {
    Account account;
    String newPath = '/account';
    Map<String, dynamic> querys = {};
    querys["googleId"] = googleId;
    Uri uri = Uri.https(authority, newPath, querys);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 200) {
      account = Account.fromJSON(jsonDecode(res.body)[0]);
    } else {
      throw Exception("failed to get account");
    }
    return account;
  }

  Future<Account> getAccountWithUserId(String userId) async {
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

  Future<bool> postAccount(Account account) async {
    String newPath = '/account';
    Uri uri = Uri.https(authority, newPath);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    account.google_id = prefs.getString('googleId') ?? '';
    Map<dynamic, dynamic> accountToPost = account.toJSON();
    accountToPost.remove("_id");
    String jsonBody = jsonEncode(accountToPost);
    http.Response res = await http.post(uri,
        headers: {
          //HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonBody);
    if (res.statusCode == 201) {
      await prefs.setString('userId', jsonDecode(res.body)["userId"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putAccount(String userId, String trainingPlanId) async {
    final queryParameters = {'userId': userId};

    String newPath = '/account';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    Account account = await getAccountWithUserId(userId);

    http.Response response = await http.put(uri,
        body: jsonEncode(account.toJSONNewActivePlan(trainingPlanId)));

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<Body> getBody(String userId) async {
    Body body;
    String newPath = '/body';
    Map<String, dynamic> querys = {};
    querys["userId"] = userId;
    Uri uri = Uri.https(authority, newPath, querys);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 200) {
      if (res.body.isEmpty) {
        return Body(" ", " ", DateTime.now(), 0, 0);
      }
      body = Body.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception("failed to get body");
    }
    return body;
  }

  Future<bool> postBody(Body body) async {
    String newPath = '/body';
    Uri uri = Uri.https(authority, newPath);

    String jsonBody = jsonEncode(body.toJSON());
    http.Response res = await http.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
        //HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
      body: jsonBody,
    );

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getBenchmarking(String exerciseName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> querys = {};
    querys["userId"] = prefs.getString('userId') ?? '';
    querys["exercise_name"] = exerciseName;
    String newPath = '/benchmarking';
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    List<StatsPair> stats = [];

    if (response.statusCode == 200) {
      List<dynamic> data = json
          .decode(response.body.toString())
          .map((item) => {
                'date': DateTime.fromMillisecondsSinceEpoch(item['date']),
                'exercise_amount': item['exercise_amount'],
              })
          .toList();

/*
      data.forEach((key, statistic) {
        StatsPair oneStatsPair = StatsPair.fromJSON(statistic);
        stats.add(oneStatsPair);
      });

      */
      for (var statistic in data) {
        StatsPair oneStatsPair = StatsPair.fromJSON(statistic);
        stats.add(oneStatsPair);
      }
    } else {
      throw Exception('Failed to load data');
    }

    return stats;
  }

  //----------------------------------------------------------------------------------------
  //---------------------------------Home Http Helper---------------------------------------
  //----------------------------------------------------------------------------------------

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
    for (var element in data) {
      days.add(TrainDay.fromJSON((element)));
    }

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

  //----------------------------------------------------------------------------------------
  //---------------------------Plan generation Http Helper----------------------------------
  //----------------------------------------------------------------------------------------

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
    TrainingDay trainingDay;

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

    final body = jsonEncode(trainingPlan.toJSONWoId());

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
        body: jsonEncode(trainingDay.toJSONWoId()));
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
        body: jsonEncode(trainingPlan.toJSON()));
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

  Future<TrainingPlan> postGeneratedPlanPreferences(
      GeneratedPlanPreferences generatedPlanPreferences) async {
    // Die gesammelten Präferenzen für generieten Trainingsplan ans Bakcned
    // übermitteln
    String newPath = '/generatedTrainingsplan';
    Uri uri = Uri.https(authority, newPath);
    TrainingPlan trainingPlan;

    final body = jsonEncode(generatedPlanPreferences.toJSON());

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

  //----------------------------------------------------------------------------------------
  //-------------------------------Tracking Http Helper-------------------------------------
  //----------------------------------------------------------------------------------------
  Future<TrainingSession> getNextTrainingSession(String trainingDayId) async {
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

    // get a session from current Plan
    TrainingDay td = await getTrainingDay(trainingDayId);
    TrainingSession nextSession = TrainingSession.fromTrainingDay(td);

    // this trainingDay has been trained before
    if (res.statusCode == 200) {
      TrainingSession lastSession =
          TrainingSession.fromJSON(jsonDecode(res.body));

      for (var exec in nextSession.executions) {
        int indexOfExec = lastSession.executions
            .indexWhere((e) => e.exercise.getId == exec.exercise.getId);

        // check if exercise was done last time
        if (indexOfExec != -1) {
          exec.sets = lastSession.executions[indexOfExec].sets;
        }
      }
    }

    return nextSession;
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

    /// creates a json from the current Session and sends it
    http.Response res = await http.post(
      uri,
      body: jsonEncode(session.toJSON()),
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
        Execution lastExecution = lastSession.executions[pos];
        lastExecution.date = lastSession.date;
        return lastExecution;
      }
    }
    return null;
  }
}
