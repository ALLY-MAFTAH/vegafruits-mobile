// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../providers/customer_provider.dart';
import '../providers/data_provider.dart';

class CustomersPage extends StatefulWidget {
  int customers = 0;
  final CustomerProvider orderProv = CustomerProvider();
  CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  void initState() {
    setState(() {
      widget.customers = widget.orderProv.customers.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
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
                  'CUSTOMERS - ${widget.customers}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: customerProvider.getAllCustomers(),
                      builder: (context, snapshot) {
                        widget.customers = customerProvider.customers.length;
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
                          return customerProvider.customers.isEmpty
                              ? RefreshIndicator(
                                  onRefresh: dataProvider.refreshData,
                                  child: ListView(
                                    children: const [
                                      Center(
                                          child: Text(
                                        "No Customer",
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
                                          customerProvider.customers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Customer thisCustomer =
                                            customerProvider.customers[index];

                                        // String formattedQuantity =
                                        //     NumberFormat('#,##0').format(
                                        //         thisCustomer.quantity);
                                        // String formattedSellingPrice =
                                        //     NumberFormat('#,##0').format(
                                        //         thisCustomer
                                        //             .product!.sellingPrice);
                                        // String formattedMinVolume =
                                        //     NumberFormat('#,##0').format(
                                        //         thisCustomer
                                        //             .product!.volume);
                                        return Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Card(
                                            child: ListTile(
                                              contentPadding: EdgeInsets.all(5),
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    "assets/images/user_icon.png"),
                                              ),
                                              title: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 35, 1, 49),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        text:
                                                            thisCustomer.name!),
                                                  ],
                                                ),
                                              ),
                                              subtitle:
                                                  Text(thisCustomer.mobile!),
                                              trailing: IconButton.filledTonal (
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons.arrow_forward_ios )),
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
