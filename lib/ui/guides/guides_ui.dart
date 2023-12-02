import 'package:flutter/material.dart';

//placeholder for guides screen
class GuidesUI extends StatelessWidget {
  const GuidesUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides'),
      ),
      body: Center(child: Text('Guides')),
    );
  }
}
