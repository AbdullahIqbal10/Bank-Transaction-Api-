import 'package:bank_transactions_app/screens/transactionDetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/transactions.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final response = await http.get(Uri.parse(
        'https://64677d7f2ea3cae8dc3091e7.mockapi.io/api/v1/transactions'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Transaction> transactions =
          (jsonData as List).map((data) => Transaction.fromJson(data)).toList();
      transactions.sort((a, b) => b.date.compareTo(a.date));
      setState(() {
        _transactions = transactions;
        _filteredTransactions = transactions;
      });
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  void _searchTransactions(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      _filteredTransactions = _transactions.where((transaction) {
        final lowerCaseType = transaction.type.toLowerCase();
        final lowerCaseDescription = transaction.description.toLowerCase();
        return lowerCaseType.contains(lowerCaseQuery) ||
            lowerCaseDescription.contains(lowerCaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Bank Transactions'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchTransactions,
              decoration: InputDecoration(
                labelText: 'Search Transactions',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = _filteredTransactions[index];
                return ListTile(
                  title: Text(
                    'Type: ${transaction.type}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${transaction.formattedDate} - ${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          transaction: transaction,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
