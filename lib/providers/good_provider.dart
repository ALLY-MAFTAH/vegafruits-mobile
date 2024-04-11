// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../constants/api.dart';
import '../models/good.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GoodProvider extends ChangeNotifier {
  bool hasError = false;
  Good selectedGood = Good();

  //
  //
  // ********** ORDERS DATA ***********
  List<Good> _goods = [];
  List<Good> get goods => _goods;
  set setGoods(List emptyGoods) => _goods = [];

  Future<void> getAllGoods() async {
    hasError = true;
    List<Good> fetchedGoods = [];

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Network Error", "No internet",
          backgroundColor: Colors.red, colorText: Colors.white);
      hasError = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http
          .get(Uri.parse('$baseApi$getGoods'))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        hasError = false;
        notifyListeners();
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });

print(response);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['goods'].forEach(($good) {
          final dataSet = Good.fromJson($good);
          fetchedGoods.add(dataSet);
        });

        _goods = fetchedGoods;
        hasError = false;
        notifyListeners();
        print(fetchedGoods);
      }
      print(goods);
    } catch (e) {
      print('EXCEPTIONNNNNNNNNNNNNNN::::::::');
      print(e);
      hasError = false;
      notifyListeners();
      Get.snackbar("Network Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
  }

  void launchPhoneDialer(String phoneNumber) async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void launchMessagingApp(String phoneNumber) async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

}
