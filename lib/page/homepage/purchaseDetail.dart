import 'package:flutter/material.dart';
import 'package:tubespariwisata/entity/purchase.dart';

class PurchaseDetail extends StatefulWidget {
  final Purchase purchase;
  const PurchaseDetail({Key? key, required this.purchase}) : super(key: key);

  @override
  State<PurchaseDetail> createState() => _PurchaseDetailState();
}

class _PurchaseDetailState extends State<PurchaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Detail'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Order ID: ${widget.purchase.orderId}'),
            subtitle: Text('Date: ${widget.purchase.purchaseDate}'),
          ),
          ListTile(
            title: Text('Product Name: ${widget.purchase.productName}'),
            subtitle: Text('Price: ${widget.purchase.price}'),
          ),
        ],
      ),
    );
  }
}
