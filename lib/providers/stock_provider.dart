// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../constants/api.dart';
import '../models/stock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StockProvider extends ChangeNotifier {
  bool hasError = false;
  Stock selectedStock = Stock();

  //
  // ********** STOCKS DATA ***********
  List<Stock> _stocks = [];
  List<Stock> get stocks => _stocks;
  set setStocks(List emptyStocks) => _stocks = [];
  Future<void> getAllStocks() async {
    hasError = true;
    List<Stock> fetchedStocks = [];

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
          .get(Uri.parse('$baseApi$getStocks'))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        hasError = false;
        notifyListeners();
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        data['stocks'].forEach(($stock) {
          final dataSet = Stock.fromJson($stock);

          fetchedStocks.add(dataSet);
        });

        _stocks = fetchedStocks;
        hasError = false;
        notifyListeners();
      }
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
