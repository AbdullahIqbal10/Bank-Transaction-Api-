import 'package:bank_transactions_app/screens/transaction_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Transactions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionsScreen(),
    );
  }
}
