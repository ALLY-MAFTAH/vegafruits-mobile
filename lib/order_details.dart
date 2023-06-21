// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegafruits/models/order.dart';

class OrderDetails extends StatefulWidget {
  Order order = Order();
  OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.number!),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: widget.order.items!
                .map((item) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 130,
                            child: Text(item.name!,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 57, 2, 98),
                                ))),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 35,
                            child: Text(
                                item.quantity!.toString().endsWith('.0')
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${NumberFormat('#,##0').format(item.price!)} TZS",
                                style: TextStyle(color: Colors.green),
                                textAlign: TextAlign.end,
                              )),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
