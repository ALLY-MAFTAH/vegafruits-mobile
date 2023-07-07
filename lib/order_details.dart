// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, void_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vegafruits/providers/order_provider.dart';

import 'components/swipe_button.dart';
import 'components/triangular_shape.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  void refreshUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    double totalAmount = 0;
    for (var item in orderProvider.selectedOrder.items!) {
      totalAmount = totalAmount + item.price!;
    }
    DateTime formattedDate1 = DateTime.parse(orderProvider.selectedOrder.date!);
    DateTime formattedDate2 =
        DateTime.parse(orderProvider.selectedOrder.deliveryDate!);
    DateFormat dateFormat = DateFormat('dd MMM, yyyy');

    String formattedTotalAmount = NumberFormat('#,##0').format(totalAmount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(orderProvider.selectedOrder.number!),
      ),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: Color.fromARGB(66, 241, 193, 59),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                children: [
                                  TextSpan(text: "Customer: "),
                                  TextSpan(
                                    text:
                                        "${orderProvider.selectedOrder.customer!.name}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              children: [
                                TextSpan(text: "Created at: "),
                                TextSpan(
                                  text: dateFormat.format(formattedDate1),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                children: [
                                  TextSpan(text: "Delivery Date: "),
                                  TextSpan(
                                    text:
                                        "${dateFormat.format(formattedDate2)} at ${orderProvider.selectedOrder.deliveryTime}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                children: [
                                  TextSpan(text: "Delivery Location: "),
                                  TextSpan(
                                    text:
                                        "${orderProvider.selectedOrder.deliveryLocation}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(66, 241, 193, 59),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Products',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(66, 241, 193, 59),
                          ),
                          Column(
                            children: orderProvider.selectedOrder.items!
                                .map((item) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 130,
                                            child: Text(item.name!,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 57, 2, 98),
                                                ))),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 35,
                                            child: Text(
                                                item.quantity!
                                                        .toString()
                                                        .endsWith('.0')
                                                    ? item.quantity!
                                                        .toString()
                                                        .replaceAll('.0', '')
                                                    : item.quantity!.toString(),
                                                style: TextStyle(
                                                  color: Colors.amber[800],
                                                ),
                                                textAlign: TextAlign.end),
                                          ),
                                        ),
                                        Container(
                                          width: 75,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            item.unit!,
                                            style: TextStyle(
                                              color: Colors.amber[800],
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                "${NumberFormat('#,##0').format(item.price!)} TZS",
                                                style: TextStyle(
                                                    color: Colors.green),
                                                textAlign: TextAlign.end,
                                              )),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Color.fromARGB(66, 241, 193, 59),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 53, 9, 71)),
                              ),
                              Text(
                                "$formattedTotalAmount TZS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 88, 1, 58)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      orderProvider.launchPhoneDialer(
                                          'tel:${orderProvider.selectedOrder.customer!.mobile}');
                                      orderProvider.updateOrderIsContacted(
                                          orderProvider.selectedOrder.id!);
                                    });
                                    refreshUI();
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.phone),
                                  label: Text("Call"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: orderProvider.selectedOrder.isPaid == 1
                                    ? Container()
                                    : IconButton.filledTonal(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirmation'),
                                                content: Text(
                                                    'Are you sure you want to mark this order as paid?'),
                                                actions: [
                                                  ElevatedButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      setState(() {
                                                        orderProvider
                                                            .updateOrderAsPaid(
                                                          orderProvider
                                                              .selectedOrder
                                                              .id!,
                                                        );
                                                      });
                                                      refreshUI();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.check,
                                            color: Colors.orange),
                                      ),
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.deepPurple),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      orderProvider.launchMessagingApp(
                                          'sms:${orderProvider.selectedOrder.customer!.mobile}');
                                      orderProvider.updateOrderIsContacted(
                                          orderProvider.selectedOrder.id!);
                                    });
                                    refreshUI();
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.message),
                                  label: Text("Text"),
                                ),
                              ),
                            ],
                          ),
                          orderProvider.selectedOrder.wasContacted == 0
                              ? Container()
                              : Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Already Contacted",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Color.fromARGB(66, 241, 193, 59),
                          ),
                          Center(
                            child: SwipeButton(
                              buttonText: 'Swipe to Serve Order',
                              onSubmitted: () =>
                                  orderProvider.updateOrderIsServed(
                                      orderProvider.selectedOrder),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 170,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 8,
                            width: 5.0,
                            child: CustomPaint(
                              painter: TriangleShape(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: orderProvider.selectedOrder.isPaid == 1
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            width: 161,
                            height: 35,
                            child: Center(
                                child: Text(
                              orderProvider.selectedOrder.isPaid == 1
                                  ? "PAID"
                                  : "NOT PAID",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
