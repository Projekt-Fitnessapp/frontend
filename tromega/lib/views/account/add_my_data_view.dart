import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tromega/data/classes/account.dart';
import 'package:tromega/data/http_helper.dart';
import 'package:tromega/data/classes/body.dart';
import 'package:tromega/widgets/shared/app_bar.dart';
import '../../widgets/account/questions_widget.dart';

//Erstellt von Rebekka Miguez//

class AddMyDataView extends StatefulWidget {
  //View zur Speicherung der einmaligen Registrierung eines neuen Users

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
          QuestionWidget(onFinished: (Account account, Body body) {
            //Account Daten versendet
            httpHelper.postAccount(account).then((account) {
              SharedPreferences.getInstance().then((prefs) {
                String userId = prefs.getString('userId') ?? '';
                body.userId = userId;
                //Body Daten versendet
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
