// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegafruits/providers/order_provider.dart';
import 'package:vegafruits/providers/sale_provider.dart';
import 'package:vegafruits/providers/stock_provider.dart';
import '../models/order.dart';

class DataProvider extends ChangeNotifier {
  bool hasError = false;
  Order selectedOrder = Order();
  final OrderProvider orderProvider = OrderProvider();
  final SaleProvider saleProvider = SaleProvider();
  final StockProvider stockProvider = StockProvider();
  //
  //
  // ********** ORDERS DATA ***********
  List<Order> _newOrders = [];
  List<Order> get newOrders => _newOrders;
  set setOrders(List emptyOrders) => _newOrders = [];

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

  Future<void> refreshData() async {
    orderProvider.getAllOrders();
    saleProvider.getAllSales();
    stockProvider.getAllStocks();
    notifyListeners();
  }
}
