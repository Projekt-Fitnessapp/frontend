import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/body.dart';

class AccountHttpHelper {
  final String authority = 'api.fitnessapp.gang-of-fork.de';

  Future<bool> accountExist(String googleId) async {
    String newPath = '/account';
    Map<String, dynamic> querys = Map();
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

  Future<Account> getAccount(String googleId) async {
    Account account;
    String newPath = '/account';
    Map<String, dynamic> querys = Map();
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
      account = Account.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception("failed to get account");
    }
    return account;
  }

  Future<bool> postAccount(Account account) async {
    String newPath = '/account';
    Uri uri = Uri.https(authority, newPath);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Body> getBody(String googleId) async {
    Body body;
    String newPath = '/body';
    Map<String, dynamic> querys = Map();
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
      body = Body.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception("failed to get body");
    }
    return body;
  }

  Future<bool> postBody(Body body) async {
    String newPath = '/body';
    Uri uri = Uri.https(authority, newPath);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response res = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      },
    );

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
