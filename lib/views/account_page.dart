// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 218, 238),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Account"),
      ),
      body: Center(
        child: Text("Account"),
      ),
    );
  }
}
