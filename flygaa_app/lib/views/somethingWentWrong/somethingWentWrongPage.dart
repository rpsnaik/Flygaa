import 'package:flutter/material.dart';

class SomethingWentWrongPage extends StatefulWidget {
  @override
  _SomethingWentWrongPageState createState() => _SomethingWentWrongPageState();
}

class _SomethingWentWrongPageState extends State<SomethingWentWrongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Something went Wrong Page"),
      ),
    );
  }
}