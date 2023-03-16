import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/account.dart';
import 'package:tromega/data/classes/benchmarking.dart';
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
      appBar: AppBarIcon(actions: const []),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          QuestionWidget(onFinished: (Account account,
              Body body,
              Benchmarking pushUps,
              Benchmarking pullUps,
              Benchmarking squads,
              Benchmarking crunches) {
            httpHelper.postAccount(account).then((account) {
              SharedPreferences.getInstance().then((prefs) async{
                String userId = prefs.getString('userId') ?? '';
                body.userId = userId;
                pullUps.userId = userId;
                pushUps.userId = userId;
                squads.userId = userId;
                crunches.userId = userId;
                await Future.wait([
                  httpHelper.postBody(body),
                  httpHelper.postBenchmarking(pushUps),
                  httpHelper.postBenchmarking(pullUps),
                  httpHelper.postBenchmarking(squads),
                  httpHelper.postBenchmarking(crunches),
                ]);
                Navigator.pushNamed(context, '/myProfile');
              });
            });
          })
        ],
      ),
    );
  }
}
