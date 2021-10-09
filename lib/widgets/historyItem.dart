import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transactions.dart';

import '../providers/historyProvider.dart';

class HistoryItem extends StatelessWidget {
  final Transaction tx;
  final double screenHeight;

  HistoryItem(this.tx, this.screenHeight);

  final prepositions = {"send": "Sent to: ", "pay": "Payed for: "};

  void confirmDelete(BuildContext context) {
    final txData = Provider.of<HistoryProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      isScrollControlled: true,
      builder: (context) {
        return Provider.value(
          value: txData,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Are you sure you want to delete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: screenHeight * 0.06,
                          child: RaisedButton(
                            onPressed: () {
                              txData.deleteTx(tx.time);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Theme.of(context).accentColor,
//                    textColor: Theme.of(context).,
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          child: RaisedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Theme.of(context).accentColor,
//                    textColor: Theme.of(context).,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            tx.type == "send" || tx.type == "pay"
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    height: screenHeight * 0.04,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Center(
                      child: Text(
                        tx.amount.toString(),
                      ),
                    ),
                  )
                : Container(
                    height: screenHeight * 0.04,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Center(
                      child: Icon(
                        Icons.money,
                      ),
                    ),
                  ),
            Expanded(
              child: Container(
                height: screenHeight * 0.05,
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tx.type == "send" || tx.type == "pay"
                        ? Row(
                            children: [
                              Text(prepositions[tx.type]),
                              Text(tx.type == "send" ? tx.recipient : tx.item),
                            ],
                          )
                        : Text("Cash out allowed for: ${tx.amount}"),
                    Text(tx.time.isBefore(DateTime(DateTime.now().year))
                        ? DateFormat.yMMMEd().format(tx.time)
                        : DateFormat.MMMEd().format(tx.time)),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                confirmDelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
