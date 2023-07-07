// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/account_page.dart';
import '../views/settings_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              otherAccountsPictures: [
                IconButton.outlined (
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm'),
                          content: Text('Are you sure you want to logout?'),
                          actions: [
                            ElevatedButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout_rounded),
                  color: Colors.white,
                )
              ],
              onDetailsPressed: () => Get.to(AccountPage()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/round-logo.jpg'),
              ),
              accountName: Text("Ally Maftah"),
              accountEmail: Text("allymaftah69@gmail.com")),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Get.to(SettingsPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info'),
            onTap: () {
              // Handle drawer item tap
            },
          ),
        ],
      ),
    );
  }
}
