// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sale.dart';
import '../providers/data_provider.dart';
import '../providers/sale_provider.dart';

class SalesPage extends StatefulWidget {
  int sales = 0;
  final SaleProvider orderProv = SaleProvider();
  SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    setState(() {
      widget.sales = widget.orderProv.sales.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SaleProvider>(context);
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
                  'SALES - ${widget.sales}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: saleProvider.getAllSales(),
                      builder: (context, snapshot) {
                        widget.sales = saleProvider.sales.length;
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
                          return saleProvider.sales.isEmpty
                              ? RefreshIndicator(
                                  onRefresh: dataProvider.refreshData,
                                  child: ListView(
                                    children: const [
                                      Center(
                                          child: Text(
                                        "No Sale",
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
                                      itemCount: saleProvider.sales.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Sale thisSale =
                                            saleProvider.sales[index];

                                        // String formattedQuantity =
                                        //     NumberFormat('#,##0').format(
                                        //         thisSale.quantity);
                                        // String formattedSellingPrice =
                                        //     NumberFormat('#,##0').format(
                                        //         thisSale
                                        //             .product!.sellingPrice);
                                        // String formattedMinVolume =
                                        //     NumberFormat('#,##0').format(
                                        //         thisSale
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
                                                        text: thisSale
                                                            .customerId!
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                              subtitle: Text(thisSale.date!),
                                              trailing: IconButton.filledTonal(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons.arrow_forward_ios)),
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
