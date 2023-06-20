import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
    leading: IconButton(
    icon: const Icon(
    Icons.arrow_back_ios,
    color: Colors.black,
    ),
    onPressed: () => Navigator.pop(context)),
    title: const Row(
    children: [
    Text(
    'Setting Screen',
    style: TextStyle(
    color: Colors.redAccent,
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    ),
    ),
    ],
    ),
    centerTitle: false,
    elevation: 0,
    ),
    body: Text('Setting Screen'),
    );
  }
}
