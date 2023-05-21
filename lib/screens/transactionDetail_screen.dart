import 'package:flutter/material.dart';

import '../model/transactions.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  TransactionDetailsScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          _buildDetailItem('Date', transaction.formattedDate),
          _buildDetailItem(
              'Amount', '${transaction.amount} ${transaction.currency}'),
          _buildDetailItem('Type', transaction.type),
          _buildDetailItem('Description', transaction.description),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
    );
  }
}
