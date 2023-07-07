// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 218, 238),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Settings"),
      ),
      body: Center(
        child: Text("Settings"),
      ),
    );
  }
}
