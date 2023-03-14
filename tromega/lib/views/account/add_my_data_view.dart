import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/account.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:tromega/data/classes/body.dart';
import 'package:tromega/widgets/shared/app_bar.dart';
import '../../widgets/account/questions_widget.dart';

class AddMyDataView extends StatefulWidget {
  const AddMyDataView({super.key, required this.googleId});
  final String googleId;

  @override
  State<AddMyDataView> createState() => _AddMyDataViewState();
}

class _AddMyDataViewState extends State<AddMyDataView> {
  late HttpHelper httpHelper;

  @override
  void initState() {
    httpHelper = const HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          QuestionWidget(onFinished: (Account account, Body body) {
            httpHelper.postAccount(account).then((account) {
              SharedPreferences.getInstance().then((prefs) {
                String userId = prefs.getString('userId') ?? '';
                body.userId = userId;
                httpHelper.postBody(body).then(
                    (value) => Navigator.pushNamed(context, '/myProfile'));
              });
            });
          })
        ],
      ),
    );
  }
}
