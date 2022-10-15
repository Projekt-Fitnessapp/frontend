import 'dart:convert';

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
}
