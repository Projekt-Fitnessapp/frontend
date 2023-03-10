import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/data/benchmarking.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/widgets/shared/app_bar.dart';
import '../../widgets/account/questions_widget.dart';

class AddMyDataView extends StatefulWidget {
  const AddMyDataView({super.key, required this.googleId});
  final String googleId;

  @override
  State<AddMyDataView> createState() => _AddMyDataViewState();
}

class _AddMyDataViewState extends State<AddMyDataView> {
  late AccountHttpHelper accountHttpHelper;

  @override
  void initState() {
    accountHttpHelper = AccountHttpHelper();
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
          QuestionWidget(onFinished:
              (Account account, Body body, Benchmarking benchmarking) {
            accountHttpHelper.postAccount(account).then((account) {
              SharedPreferences.getInstance().then((prefs) {
                String userId = prefs.getString('userId') ?? '';
                body.userId = userId;
                benchmarking.userId = userId;
                accountHttpHelper.postBenchmarking(benchmarking);
                accountHttpHelper.postBody(body).then(
                    (value) => Navigator.pushNamed(context, '/myProfile'));
              });
            });
          })
        ],
      ),
    );
  }
}
