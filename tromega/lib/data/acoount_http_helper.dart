import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tromega/data/account.dart';
import 'package:tromega/data/body.dart';

class AccountHttpHelper {
  final String authority = 'virtserver.swaggerhub.com';
  final String path = '/FLORIANHASE12/GEtit/1.0.0';

  Future<bool> accountExist(String googleId) async {
    String newPath = '$path/account';
    Map<String, dynamic> querys = Map();
    querys["googleId"] = googleId;
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Account> getAccount(String googleId) async {
    Account account;
    String newPath = '$path/account';
    Map<String, dynamic> querys = Map();
    querys["googleId"] = googleId;
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      account = Account.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception("failed to get account");
    }
    return account;
  }

  Future<bool> postAccount(Account account) async {
    String newPath = '$path/account';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.post(uri);

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Body> getBody(String googleId) async {
    Body body;
    String newPath = '$path/body';
    Map<String, dynamic> querys = Map();
    querys["googleId"] = googleId;
    Uri uri = Uri.https(authority, newPath, querys);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      body = Body.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception("failed to get body");
    }
    return body;
  }

  Future<bool> postBody() async {
    String newPath = '$path/body';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.post(uri);

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
