import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/stats_pair.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tromega/data/stats_http_helper.dart';

class StatsHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<dynamic> getBenchmarking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> querys = {};
    querys["userId"] = '5099803df3f414add2f9dba7' ?? '';
    querys["exercise_name"] = 'weightlifting';
    String newPath = '/benchmarking';
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    List<StatsPair> stats = [];
    List<dynamic> data = json.decode(response.body.toString());

    return data
        .map((item) => {
              'date': DateTime.fromMillisecondsSinceEpoch(item['date']),
              'exercise_amount': item['exercise_amount'],
            })
        .toList();
  }
}
