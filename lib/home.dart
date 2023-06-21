// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vegafruits/order_details.dart';
import 'package:vegafruits/providers/data_provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  int newOrders = 0;
  final dataProvider = DataProvider();

  final DataProvider provider = DataProvider();
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    setState(() {
      widget.newOrders = widget.dataProvider.newOrders.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
              child: Image(
            image: AssetImage("assets/images/logo.png"),
            height: 50,
          )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.orange,
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    'NEW ORDERS - ${widget.newOrders}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: dataProvider.getAllOrders(),
                        builder: (context, snapshot) {
                          widget.newOrders = dataProvider.newOrders.length;
                          if (snapshot.hasData) {
                            return RefreshIndicator(
                                onRefresh: dataProvider.refreshData,
                                child: Center(
                                    child: ListView(
                                  children: const [
                                    Center(child: CircularProgressIndicator()),
                                  ],
                                )));
                          } else {
                            return dataProvider.newOrders.isEmpty
                                ? RefreshIndicator(
                                    onRefresh: dataProvider.refreshData,
                                    child: ListView(
                                      children: const [
                                        Center(
                                            child: Text(
                                          "No New Order",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                : RefreshIndicator(
                                    onRefresh: dataProvider.refreshData,
                                    child: ListView.builder(
                                        itemCount:
                                            dataProvider.newOrders.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          double totalAmount = 0;
                                          for (var item in dataProvider
                                              .newOrders[index].items!) {
                                            totalAmount =
                                                totalAmount + item.price!;
                                          }
                                          DateTime formattedDate1 =
                                              DateTime.parse(dataProvider
                                                  .newOrders[index].date!);
                                          DateTime formattedDate2 =
                                              DateTime.parse(dataProvider
                                                  .newOrders[index]
                                                  .deliveryDate!);
                                          DateFormat dateFormat =
                                              DateFormat('dd MMM, yyyy');

                                          String formattedTotalAmount =
                                              NumberFormat('#,##0')
                                                  .format(totalAmount);
                                          return InkWell(
                                            onTap: () {
                                              Get.to(OrderDetails(
                                                  order: dataProvider
                                                      .newOrders[index]));
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Order #: ${dataProvider.newOrders[index].number}",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        57,
                                                                        2,
                                                                        98),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                dataProvider
                                                                            .newOrders[
                                                                                index]
                                                                            .isPaid ==
                                                                        1
                                                                    ? Icons
                                                                        .check
                                                                    : Icons
                                                                        .cancel,
                                                                color: dataProvider
                                                                            .newOrders[
                                                                                index]
                                                                            .isPaid ==
                                                                        1
                                                                    ? Color
                                                                        .fromARGB(
                                                                        255,
                                                                        38,
                                                                        131,
                                                                        1,
                                                                      )
                                                                    : Colors
                                                                        .redAccent,
                                                                size: 18,
                                                              ),
                                                              Text(
                                                                "$formattedTotalAmount TZS",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: dataProvider.newOrders[index].isPaid ==
                                                                            0
                                                                        ? Colors
                                                                            .red
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            38,
                                                                            131,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color: Color.fromARGB(
                                                            66, 241, 193, 59),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                            "Customer: ${dataProvider.newOrders[index].customer!.name}"),
                                                      ),
                                                      Text(
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                          "Created at: ${dateFormat.format(formattedDate1)}"),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                            "Delivery:  ${dataProvider.newOrders[index].deliveryLocation} On ${dateFormat.format(formattedDate2)} at ${dataProvider.newOrders[index].deliveryTime}"),
                                                      ),
                                                      Divider(
                                                        color: Color.fromARGB(
                                                            66, 241, 193, 59),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton
                                                                    .icon(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Color.fromARGB(255, 88, 1, 58)),
                                                                foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                              ),
                                                              onPressed: () {
                                                                dataProvider
                                                                    .launchPhoneDialer(
                                                                        'tel:${dataProvider.newOrders[index].customer!.mobile}');
                                                                dataProvider.updateOrderIsContacted(
                                                                    dataProvider
                                                                        .newOrders[
                                                                            index]
                                                                        .id!);
                                                              },
                                                              icon: Icon(
                                                                  Icons.phone),
                                                              label:
                                                                  Text("Call"),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30,
                                                                    right: 30),
                                                            child: dataProvider
                                                                        .newOrders[
                                                                            index]
                                                                        .isPaid ==
                                                                    1
                                                                ? Container()
                                                                : IconButton
                                                                    .filledTonal(
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Confirmation'),
                                                                            content:
                                                                                Text('Are you sure you want to mark this order as paid?'),
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
                                                                                  dataProvider.updateOrderIsPaid(
                                                                                    dataProvider.newOrders[index].id!,
                                                                                  );
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .orange),
                                                                  ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton
                                                                    .icon(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .deepPurple),
                                                                foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                              ),
                                                              onPressed: () {
                                                                dataProvider
                                                                    .launchMessagingApp(
                                                                        'sms:${dataProvider.newOrders[index].customer!.mobile}');
                                                                dataProvider.updateOrderIsContacted(
                                                                    dataProvider
                                                                        .newOrders[
                                                                            index]
                                                                        .id!);
                                                              },
                                                              icon: Icon(Icons
                                                                  .message),
                                                              label:
                                                                  Text("Text"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      dataProvider
                                                                  .newOrders[
                                                                      index]
                                                                  .wasContacted ==
                                                              0
                                                          ? Container()
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                              child: Text(
                                                                "Already Contacted",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
