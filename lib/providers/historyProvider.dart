import 'package:flutter/material.dart';

import '../models/transactions.dart';

class HistoryProvider with ChangeNotifier {
  List<Transaction> _transactions = [
    // Transaction.pay(
    //   amount: 500,
    //   recipient: "0551882812",
    //   reference: "test 1",
    //   item: "Shoe"
    // ),
    // Transaction.send(
    //   amount: 500,
    //   recipient: "0551882812",
    //   reference: "test 1",
    // ),
    // Transaction.withdraw(
    //   amount: 200,
    // ),
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  void addTx(tx) {
    _transactions.insert(0, tx);
    notifyListeners();
  }

  void deleteTx(txTime) {
    _transactions.removeWhere((element) => element.time == txTime);
    notifyListeners();
  }
}
