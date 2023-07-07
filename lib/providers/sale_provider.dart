// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../constants/api.dart';
import '../models/sale.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SaleProvider extends ChangeNotifier {
  bool hasError = false;
  Sale selectedSale = Sale();

  //
  //
  // ********** ORDERS DATA ***********
  List<Sale> _newSales = [];
  List<Sale> get newSales => _newSales;
  set setSales(List emptySales) => _newSales = [];

  Future<void> getAllSales() async {
    hasError = true;
    List<Sale> fetchedSales = [];

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
          .get(Uri.parse('$baseApi$getSales'))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        hasError = false;
        notifyListeners();
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['sales'].forEach(($sale) {
          final dataSet = Sale.fromJson($sale);
          fetchedSales.add(dataSet);
        });

        _newSales = fetchedSales;
        hasError = false;
        notifyListeners();
        print(fetchedSales);
      }
      print(newSales);
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
