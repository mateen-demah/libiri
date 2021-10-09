import 'package:flutter/material.dart';
import 'package:libiri/providers/historyProvider.dart';
import 'package:provider/provider.dart';

import 'historyItem.dart';

class TxHistory extends StatefulWidget {
  final double screenHeight;

  TxHistory(this.screenHeight);

  @override
  State<StatefulWidget> createState() => TxHistoryState();
}

class TxHistoryState extends State<TxHistory> {
  @override
  Widget build(BuildContext context) {
    final txData = Provider.of<HistoryProvider>(context);
    final transactions = txData.transactions;

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.001,
            right: MediaQuery.of(context).size.width * 0.001),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25
            ),
          ),
          elevation: 4,
          shadowColor: Theme.of(context).primaryColorLight,
          child: Column(
            children: [
              SizedBox(
                height: widget.screenHeight * 0.05,
                child: Center(
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return HistoryItem(transactions[index], widget.screenHeight);
                  },
                  itemCount: transactions.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
