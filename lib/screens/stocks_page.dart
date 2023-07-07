// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:vegafruits/constants/api.dart';
import '../models/stock.dart';
import '../providers/data_provider.dart';
import '../providers/stock_provider.dart';

class StocksPage extends StatefulWidget {
  int stocks = 0;
  final StockProvider orderProv = StockProvider();
  StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  @override
  void initState() {
    setState(() {
      widget.stocks = widget.orderProv.stocks.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
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
                  'PRODUCTS - ${widget.stocks}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: stockProvider.getAllStocks(),
                      builder: (context, snapshot) {
                        widget.stocks = stockProvider.stocks.length;
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
                          return stockProvider.stocks.isEmpty
                              ? RefreshIndicator(
                                  onRefresh: dataProvider.refreshData,
                                  child: ListView(
                                    children: const [
                                      Center(
                                          child: Text(
                                        "No New Stock",
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
                                      itemCount: stockProvider.stocks.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {

                                        Stock thisStock =
                                            stockProvider.stocks[index];

                                        String formattedQuantity =
                                            NumberFormat('#,##0').format(
                                                thisStock.quantity);
                                        String formattedSellingPrice =
                                            NumberFormat('#,##0').format(
                                                thisStock
                                                    .product!.sellingPrice);
                                        String formattedMinVolume =
                                            NumberFormat('#,##0').format(
                                                thisStock
                                                    .product!.volume);
                                        return Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Card(
                                            child: ListTile(
                                              contentPadding: EdgeInsets.all(5),
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    "$baseApi$productPhoto/${thisStock.id}"),
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
                                                        text: thisStock.name!),
                                                    TextSpan(text: " "),
                                                    TextSpan(
                                                      text:
                                                          " (${thisStock.type!})",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Price: $formattedSellingPrice TZS"),
                                                  Row(
                                                    children: [
                                                      Text("Discount: ", style:TextStyle(fontSize:12)),
                                                        thisStock.product!.hasDiscount==1?
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  183,
                                                                  221,
                                                                  134),
                                                          radius: 8,
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 15,
                                                          )): CircleAvatar(
                                                          backgroundColor:
                                                              Color.fromARGB(255, 221, 134, 134),
                                                          radius: 8,
                                                          child: Icon(
                                                            Icons.close ,
                                                            size: 15,
                                                          )),
                                                          SizedBox(width: 10,),
                                                          Text("Min. Qty: ", style:TextStyle(fontSize:12)),
                                                          Text(formattedMinVolume, style:TextStyle(fontSize:12)),
                                                          Text(thisStock.unit!, style:TextStyle(fontSize:12))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              trailing: Column(
                                                children: [
                                                  Text(
                                                    "Remained",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(formattedQuantity, style: TextStyle(fontSize: 15, color: Colors.deepPurple),),
                                                  Text(thisStock.unit!, style: TextStyle(color: Colors.deepPurple),),
                                                ],
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
