import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String date;
  final double amount;
  final String currency;
  final String type;
  final String description;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.currency,
    required this.type,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['date'],
      amount: double.parse(json['amount'].toString()),
      currency: json['currency'],
      type: json['type'],
      description: json['description'],
    );
  }

  String get formattedDate {
    final parsedDate = DateTime.parse(date);
    final formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(parsedDate);
  }

  Map<String, String> toMap() {
    return {
      'Date': formattedDate,
      'Amount': '$amount $currency',
      'Type': type,
      'Description': description,
    };
  }
}
