import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/account.dart';
import 'package:tromega/data/body.dart';
import 'package:tromega/data/account_http_helper.dart';
import 'package:tromega/widgets/shared/app_bar.dart';
import '../../widgets/account/first_questions_widget.dart';
import '../../widgets/account/second_questions_widget.dart';

class AddMyDataView extends StatefulWidget {
  const AddMyDataView({super.key, required this.googleId});
  final String googleId;

  @override
  State<AddMyDataView> createState() => _AddMyDataViewState();
}

class _AddMyDataViewState extends State<AddMyDataView> {
  late int page;
  late AccountHttpHelper accountHttpHelper;

  @override
  void initState() {
    accountHttpHelper = AccountHttpHelper();
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: []),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          page == 0
              ? FirstQuestionWidget(
                  onClick: () {
                    setState(() {
                      page++;
                    });
                  },
                )
              : SecondQuestionWidget(onFinished: () {
                  accountHttpHelper.getAccount(widget.googleId).then((account) {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setString('userId', account.id);
                    });
                  });
                })
        ],
      ),
    );
  }
}
