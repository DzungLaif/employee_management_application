import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worker_app/controllers/controllers.dart';
import 'package:worker_app/localizations.dart';

//placeholder for feedback screen
class FeedbackUI extends StatelessWidget {
  const FeedbackUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<AuthController>(
        builder: (controller) => controller?.firestoreUser?.value?.uid != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text('Feedback & Chat'), //implement localization
                  actions: [
                    IconButton(icon: Icon(Icons.account_box), onPressed: () {}),
                  ],
                ),
                body: Stack())
            : Text('No user data'));
  }
}
