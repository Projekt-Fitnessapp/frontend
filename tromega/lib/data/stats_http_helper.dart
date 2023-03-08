import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/stats_pair.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tromega/data/stats_http_helper.dart';

class StatsHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

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
}
