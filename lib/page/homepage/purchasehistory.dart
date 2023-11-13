import 'package:flutter/material.dart';
import 'package:tubespariwisata/page/homepage/purchaseDetail.dart';
import 'package:tubespariwisata/entity/purchase.dart';

class PurchaseHistoryPage extends StatefulWidget {
  const PurchaseHistoryPage({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  List<Purchase> purchaseList = [
    Purchase(
        orderId: '1',
        productName: 'Borobudur',
        price: 100000.00,
        purchaseDate: DateTime.now()),
  ]; // Daftar pembelian

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
      ),
      body: ListView.builder(
        itemCount: purchaseList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order ID: ${purchaseList[index].orderId}'),
            subtitle: Text('Date: ${purchaseList[index].purchaseDate}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PurchaseDetail(purchase: purchaseList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
