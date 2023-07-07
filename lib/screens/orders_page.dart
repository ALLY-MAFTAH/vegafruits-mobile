// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vegafruits/order_details.dart';
import 'package:intl/intl.dart';

import '../providers/data_provider.dart';
import '../providers/order_provider.dart';

class OrdersPage extends StatefulWidget {
  int newOrders = 0;
  final OrderProvider orderProv = OrderProvider();
  OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    setState(() {
      widget.newOrders = widget.orderProv.newOrders.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              // color: Color.fromARGB(255, 248, 234, 213),
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
                      future: orderProvider.getAllOrders(),
                      builder: (context, snapshot) {
                        widget.newOrders = orderProvider.newOrders.length;
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
                          return orderProvider.newOrders.isEmpty
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
                                      itemCount: orderProvider.newOrders.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        double totalAmount = 0;
                                        for (var item in orderProvider
                                            .newOrders[index].items!) {
                                          totalAmount =
                                              totalAmount + item.price!;
                                        }
                                        DateTime formattedDate1 =
                                            DateTime.parse(orderProvider
                                                .newOrders[index].date!);
                                        DateTime formattedDate2 =
                                            DateTime.parse(orderProvider
                                                .newOrders[index]
                                                .deliveryDate!);
                                        DateFormat dateFormat =
                                            DateFormat('dd MMM, yyyy');

                                        String formattedTotalAmount =
                                            NumberFormat('#,##0')
                                                .format(totalAmount);
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              orderProvider.selectedOrder =
                                                  orderProvider.newOrders[index];
                                            });
                                            Get.to(OrderDetails());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 5,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Color.fromARGB(255, 252, 248, 228),
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
                                                          "Order #: ${orderProvider.newOrders[index].number}",
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
                                                              orderProvider
                                                                          .newOrders[
                                                                              index]
                                                                          .isPaid ==
                                                                      1
                                                                  ? Icons.check
                                                                  : Icons
                                                                      .cancel,
                                                              color: orderProvider
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
                                                                  fontSize: 16,
                                                                  color: orderProvider
                                                                              .newOrders[
                                                                                  index]
                                                                              .isPaid ==
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
                                                                  TextAlign.end,
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
                                                          "Customer: ${orderProvider.newOrders[index].customer!.name}"),
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
                                                          "Delivery:  ${orderProvider.newOrders[index].deliveryLocation} On ${dateFormat.format(formattedDate2)} at ${orderProvider.newOrders[index].deliveryTime}"),
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
                                                          child: ElevatedButton
                                                              .icon(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          88,
                                                                          1,
                                                                          58)),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {
                                                              orderProvider
                                                                  .launchPhoneDialer(
                                                                      'tel:${orderProvider.newOrders[index].customer!.mobile}');
                                                              orderProvider.updateOrderIsContacted(
                                                                  orderProvider
                                                                      .newOrders[
                                                                          index]
                                                                      .id!);
                                                            },
                                                            icon: Icon(
                                                                Icons.phone),
                                                            label: Text("Call"),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 30,
                                                                  right: 30),
                                                          child: orderProvider
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
                                                                                orderProvider.updateOrderAsPaid(
                                                                                  orderProvider.newOrders[index].id!,
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
                                                          child: ElevatedButton
                                                              .icon(
                                                            style: ButtonStyle(
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
                                                              orderProvider
                                                                  .launchMessagingApp(
                                                                      'sms:${orderProvider.newOrders[index].customer!.mobile}');
                                                              orderProvider.updateOrderIsContacted(
                                                                  orderProvider
                                                                      .newOrders[
                                                                          index]
                                                                      .id!);
                                                            },
                                                            icon: Icon(
                                                                Icons.message),
                                                            label: Text("Text"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    orderProvider
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
                                                                  fontSize: 12),
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
    );
  }
}
