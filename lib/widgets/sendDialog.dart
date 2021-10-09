import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transactions.dart';

import '../providers/historyProvider.dart';

class SendDialog extends StatefulWidget {
  final double screenHeight;

  SendDialog(this.screenHeight);

  @override
  State<StatefulWidget> createState() => _SendDialogState();
}

class _SendDialogState extends State<SendDialog> {
  final recipientController = TextEditingController();
  final referenceController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txData = Provider.of<HistoryProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "recipient's number",
                hintText: "example: '024xxxxxxx'",
              ),
              controller: recipientController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Reference",
                hintText: "Your name is used by default",
              ),
              controller: referenceController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
                prefixText: "GH₵ ",
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    height: widget.screenHeight * 0.06,
                    child: RaisedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
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
                    height: widget.screenHeight * 0.06,
                    child: RaisedButton(
                      onPressed: () {
                        Transaction newTx = Transaction.send(
                          amount: double.parse(amountController.text),
                          reference: referenceController.text,
                          recipient: recipientController.text,
                        );
                        txData.addTx(newTx);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Continue",
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
    );
  }
}
