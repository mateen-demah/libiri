import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'dart:math';

import 'package:libiri/providers/historyProvider.dart';

import '../models/transactions.dart';

class WithdrawDialog extends StatefulWidget {
  final double screenHeight;

  WithdrawDialog(this.screenHeight);

  @override
  State<StatefulWidget> createState() => WithdrawDialogState();
}

class WithdrawDialogState extends State<WithdrawDialog> {
  final amountController = TextEditingController();
  bool cashOutAllowed = false;

  static const _hover = const MethodChannel('kinsaga.libiri/hover');
  String _ActionResponse = 'Waiting for Response...';
  // print("===============================================");

  Future<dynamic> allowco() async {
    // var sendMap = <String, dynamic>{
    //   'phoneNumber': "phoneNumber",
    //   'amount': amount,
    // };
// response waits for result from java code
    String response = "";
    try {
      final String result = await _hover.invokeMethod('allowco');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    _ActionResponse = response;
    print('================================== response');
    print(_ActionResponse);
    print('================================== response');
  }

  @override
  Widget build(BuildContext context) {
    final txData = Provider.of<HistoryProvider>(context);
    final qrCodeLength =
        min(MediaQuery.of(context).size.width, widget.screenHeight) * 0.5;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: cashOutAllowed == true
            ? Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.1),
                child: Center(
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: '${amountController.text}',
                    color: Colors.black,
                    width: qrCodeLength,
                    height: qrCodeLength,
                  ),
                ),
              )
            : Column(
                children: [
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
                    child: Text(
                      "Only Allow cash out if you are about to withdraw from an agent !!!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
                              Transaction newTx = Transaction.withdraw(
                                  amount: double.parse(amountController.text));
                              txData.addTx(newTx);
                              allowco();
                              setState(() {
                                cashOutAllowed = true;
                              });
                            },
                            child: Text(
                              "Allow cash out",
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
