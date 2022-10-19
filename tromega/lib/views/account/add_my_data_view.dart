import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/account_http_helper.dart';
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
      appBar: AppBar_Icon(actions: []),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          QuestionWidget(onFinished: () {
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
