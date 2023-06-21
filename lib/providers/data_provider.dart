// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../constants/api.dart';
import '../models/order.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DataProvider extends ChangeNotifier {
  bool hasError = false;

  //
  //
  // ********** ORDERS DATA ***********
  List<Order> _newOrders = [];

  List<Order> get newOrders => _newOrders;
  set setOrders(List emptyOrders) => _newOrders = [];

  Future<void> getAllOrders() async {
    List<Order> fetchedOrders = [];

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Network Error", "No internet",
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();
      return;
    }

    try {
      final response = await http
          .get(Uri.parse('$baseApi$getNewOrders'))
          .timeout(const Duration(seconds: 6), onTimeout: () {
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });
      notifyListeners();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['orders'].forEach(($order) {
          final dataSet = Order.fromJson($order);
          fetchedOrders.add(dataSet);
        });

        _newOrders = fetchedOrders;
        print(fetchedOrders);
        print(fetchedOrders.length);
      }
      print(newOrders);
    } catch (e) {
      print('EXCEPTIONNNNNNNNNNNNNNN::::::::');
      print(e);
      hasError = true;
      notifyListeners();
      Get.snackbar("Network Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();
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

  void updateOrderIsPaid(int orderId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Network Error", "No internet",
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();
      return;
    }
    try {
      final url = Uri.parse('$baseApi$markOrderAsPaid$orderId');

      final headers = {
        'Content-Type': 'application/json',
      };
      final requestBody = {
        'is_paid': 1,
      };
      final response = await http
          .patch(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      )
          .timeout(const Duration(seconds: 6), onTimeout: () {
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });
      notifyListeners();

      if (response.statusCode == 200) {
        print('Order marked as paid successfully!');
        refreshData();
        Get.snackbar("Success", "Order successfull marked as paid",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(
            'Failed to mark order as paid. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to mark order as paid",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('An error occurred while updating order: $e');
      Get.snackbar("Exception", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();

      return;
    }
  }

  void updateOrderIsContacted(int orderId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Network Error", "No internet",
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();

      return;
    }
    try {
      final url = Uri.parse('$baseApi$markOrderAsContacted$orderId');

      final headers = {
        'Content-Type': 'application/json',
      };
      final requestBody = {
        'was_contacted': 1,
      };
      final response = await http
          .patch(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      )
          .timeout(const Duration(seconds: 6), onTimeout: () {
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });
      notifyListeners();

      if (response.statusCode == 200) {
        print('Order marked as contacted successfully!');
        refreshData();
        Get.snackbar("Success", "Customer successfull marked as contacted",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(
            'Failed to mark customer as contacted. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to mark customer as contacted",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('An error occurred while updating order: $e');
      Get.snackbar("Exception", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();

      return;
    }
  }

  void updateOrderIsServed(int orderId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Network Error", "No internet",
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();

      return;
    }
    try {
      final url = Uri.parse('$baseApi$markOrderAsServed$orderId');

      final headers = {
        'Content-Type': 'application/json',
      };
      final requestBody = {
        'status': 1,
      };
      final response = await http
          .patch(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      )
          .timeout(const Duration(seconds: 6), onTimeout: () {
        throw TimeoutException("Connection Problem, Please Try Again Latter");
      });
      notifyListeners();

      if (response.statusCode == 200) {
        print('Order marked as sold successfully!');
        refreshData();
        Get.snackbar("Success", "Order successfull marked as sold",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print(
            'Failed to mark order as sold. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to mark order as sold",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('An error occurred while updating order: $e');
      Get.snackbar("Exception", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      notifyListeners();

      return;
    }
  }

  Future<void> refreshData() async {
    getAllOrders();
    notifyListeners();
  }
}
