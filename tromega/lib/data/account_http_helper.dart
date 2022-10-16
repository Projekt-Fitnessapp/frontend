import 'dart:convert';

import 'package:tromega/data/body.dart';
import 'package:tromega/data/userAccount.dart';
import 'package:http/http.dart' as http;

class AccountHttpHelper {
  //final String authority = 'api.fitnessapp.gang-of-fork.de';
  final String authority = 'virtserver.swaggerhub.com';
  final String path = '/FLORIANHASE12/GEtit/1.0.0';

  Future<UserAccount> getAccount(String userId) async {
    final queryParameters = {'userId': userId};
    UserAccount userAccount;

    String newPath = '$path/account';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      userAccount = UserAccount.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load Account');
    }

    return userAccount;
  }

  Future<bool> postAccount(UserAccount userAccount) async {
    String newPath = '$path/account';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.post(uri, body: {userAccount});

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putAccount(String userId, UserAccount userAccount) async {
    final queryParameters = {'userId': userId};
    String newPath = '$path/account';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.put(uri, body: {userAccount});

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }


  Future<Body> getBody(String userId) async {
    final queryParameters = {'userId': userId};
    Body body;

    String newPath = '$path/body';
    Uri uri = Uri.https(authority, newPath, queryParameters);

    http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      body = Body.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load Body');
    }

    return body;
  }

  Future<bool> postBody(Body body) async {
    String newPath = '$path/body';
    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.post(uri, body: {body});

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
