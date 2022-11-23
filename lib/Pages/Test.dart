import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        SharedPreferences pref = await SharedPreferences.getInstance();
    Map json = jsonDecode(pref.getString('userData'));
    var user = UserModel.fromJson(json);
    );
  }
}
